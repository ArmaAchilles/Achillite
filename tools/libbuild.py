import os
from pathlib import Path
import shutil
import re
from string import Template
import subprocess

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

def build_composition(init_body, build_root=Path('../build'), tpl_root=Path('../composition'), meta_data={}):
    init_done_var = '{MOD_PREFIX}_initDone'.format(**meta_data)
    init_body = minimize('''
        if(local this)then{{
            if(isNil "{INIT_DONE_VAR}")then{{
                {INIT_BODY};
                [objNull,"{MOD_NAME} ({MOD_VERSION}) initialized!"]call BIS_fnc_showCuratorFeedbackMessage;
                {INIT_DONE_VAR}=true;
                [missionNamespace, "{INIT_DONE_VAR}"] call BIS_fnc_callScriptedEventHandler;
                [missionNamespace, "{INIT_DONE_VAR}"] call BIS_fnc_removeAllScriptedEventHandlers;
            }};
        deleteVehicle this
    }}'''.format(**meta_data, INIT_BODY=init_body, INIT_DONE_VAR=init_done_var))
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
            COMPOSITION_NAME = '{MOD_NAME} Initializer ({MOD_VERSION})'.format(**meta_data),
            COMPOSITION_AUTHOR = meta_data['MOD_AUTHOR']
        )
    with open(composition_dir / 'header.sqe', 'w') as stream:
        stream.write(body)

    shutil.make_archive(build_root / '{MOD_NAME}_{MOD_VERSION}'.format(**meta_data), 'zip', composition_dir)
