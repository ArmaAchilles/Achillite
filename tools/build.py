import os
from pathlib import Path
import shutil
import json
import re
from string import Template
import subprocess
from sqf_validator import main as validator

os.chdir(Path(__file__).parent)
with open('../meta.json', 'r') as stream:
    meta_data = json.load(stream)

src_root = Path('../components')
tpl_root = Path('../composition')
build_root = Path('../build')

def preprocess(file):
    if os.name == 'nt':
        # Use CL on Windows
        subprocess.check_output(['CL', '/P', file.name], cwd=file.parent)
        with file.with_suffix('.i').open('r') as stream:
            lines = stream.readlines()
    else:
        # Use GCC on Linux
        output = subprocess.check_output(['gcc', '-x', 'c', '-E', str(file)])
        lines = output.decode('utf8').splitlines()
    lines = filter(lambda line: not line.startswith('#'), lines)
    return os.linesep.join(lines)

def minimize(body):
    # remove whitespace and add dummy characters at end
    body = body.strip() + 3*'\0'
    prev_char = ''
    tmp_body = ''
    is_string = False
    buffer = body[:3]
    for i_char in range(len(body) - 3):
        i_char_delete = -1

        if buffer[1] == '"':
            is_string = not is_string
        elif buffer[1].isspace():
            if not is_string and (
                buffer[2].isspace() or
                re.match('\W', buffer[0]) or
                re.match('\W', buffer[2])
            ):
                i_char_delete = 1
        elif buffer[:2] == ';;':
            i_char_delete = 1
        elif buffer[:2] == ';}':
            i_char_delete = 0

        if i_char_delete == 0:
            buffer = buffer[1:] + body[i_char+3]
        elif i_char_delete == 1:
            buffer = buffer[0] + buffer[2] + body[i_char+3]
        else:
            tmp_body += buffer[0]
            buffer = buffer[1:] + body[i_char+3]

    return tmp_body

def build_composition(init_body):
    init_body = minimize(f'''
        if(local this)then{{
            if(isNil "{meta_data["MOD_PREFIX"]}_initDone")then{{
                {init_body}
                [objNull,"{meta_data["MOD_NAME"]} initialized!"]call BIS_fnc_showCuratorFeedbackMessage;
                {meta_data["MOD_PREFIX"]}_initDone=true
            }};
        deleteVehicle this
    }}''')
    init_body = init_body.replace('"', '""')

    composition_dir = build_root / meta_data['MOD_NAME']
    composition_dir.mkdir(exist_ok=True, parents=True)

    with open(tpl_root / 'composition.sqe', 'r') as stream:
        body = Template(stream.read()).safe_substitute(
            COMPOSITION_INIT = init_body
        )
    with open(composition_dir / 'composition.sqe', 'w') as stream:
        stream.write(body)

    with open(tpl_root / 'header.sqe', 'r') as stream:
        body = Template(stream.read()).safe_substitute(
            COMPOSITION_NAME = f'{meta_data["MOD_NAME"]} Initializer',
            COMPOSITION_AUTHOR = meta_data['MOD_AUTHOR']
        )
    with open(composition_dir / 'header.sqe', 'w') as stream:
        stream.write(body)

    shutil.make_archive(build_root / meta_data["MOD_NAME"], 'zip', composition_dir)

if __name__ == '__main__':
    if validator():
        raise RuntimeError('SQF Validation FAILED')
    print()
    print('PROCESSING COMPONENTS')
    print('---------------------')
    print()
    i_fnc = 0
    preInitBody = ''
    initBody = ''
    postInitBody = ''
    for component_dir in src_root.iterdir():
        if component_dir.is_file():
            continue
        for sqf_file in component_dir.glob('*.sqf'):
            sqf_stem = sqf_file.stem
            content = preprocess(sqf_file)
            # Execute module registration directly
            if sqf_stem.startswith('init'):
                initBody += f'{content};'
            elif sqf_stem == 'XEH_preInit':
                preInitBody += f'{content};'
            elif sqf_stem == 'XEH_postInit':
                postInitBody += f'{content};'
            # Store all other functions in variables
            else:
                fnc_var = f'{meta_data["MOD_PREFIX"]}_{sqf_stem}'
                preInitBody += f'{fnc_var}={{{content}}};'
            i_fnc += 1
    body = preInitBody + initBody + postInitBody
    print(f'Processed {i_fnc} functions, {len(body.encode("utf8")) / 1e6:.3f} MB in total.')
    print()
    print('BUILDING COMPOSITION')
    print('---------------------')
    print()
    build_composition(body)
    print(f'Build completed!')
