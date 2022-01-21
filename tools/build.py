import os
from pathlib import Path
import json
import re
from string import Template
import subprocess
from sqf_validator import main as validator

os.chdir(Path(__file__).parent)
with open('../meta.json', 'r') as stream:
    meta_data = json.load(stream)
with open('../meta.json', 'r') as stream:
    meta_data = json.load(stream)

src_root = Path('../components')
tpl_root = Path('../template')
build_root = Path('../build')

def preprocess(file):
    output = subprocess.check_output(['gcc', '-x', 'c', '-E', str(file)])
    lines = output.decode('utf8').splitlines()
    lines = filter(lambda line: not line.startswith('#'), lines)
    return os.linesep.join(lines)

def minimize(body):
    body = re.sub(r"localize\s*\"([^\W]*)\"", lambda x: '"{}"'.format(localizeString(x.group(1))), body)
    # remove whitespace
    body = re.sub(r"\s+([\W])", r"\1", body)
    body = re.sub(r"([\W])\s+", r"\1", body)
    body = re.sub(r"([^\W])\s+([^\W])", r"\1 \2", body)
    body = re.sub(r"^\s+([^\s])", r"\1", body)
    # remove extra semicolons
    body = re.sub(r";}", r"}", body)
    return body

def build_composition(init_body):
    init_body = init_body.replace('"', '""')
    init_body = f'if(local this)then{{{init_body}deleteVehicle this}}'
    
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

if __name__ == '__main__':
    if validator():
        raise RuntimeError('SQF Validation FAILED')
    print()
    print('PROCESSING COMPONENTS')
    print('---------------------')
    print()
    i_fn = 0
    body = ''
    for component_dir in src_root.iterdir():
        if component_dir.is_file():
            continue
        component_name = component_dir.stem
        for fn_file in component_dir.glob('functions/fn_*.sqf'):
            fn_name = fn_file.stem[3:]
            if component_name == 'common':
                fn_var = f'{meta_data["MOD_PREFIX"]}_fnc_{fn_name}'
            else:
                fn_var = f'{meta_data["MOD_PREFIX"]}_{component_name}_fnc_{fn_name}'
            content = minimize(preprocess(fn_file))
            body += f'{fn_var}={content};'
            i_fn += 1
    print(f'Processed {i_fn} functions, {len(body.encode("utf8")) / 1e3:.1f} KB in total.')
    print()
    print('BUILDING COMPOSITION')
    print('---------------------')
    print()
    build_composition(body)
    print(f'Build completed!')
