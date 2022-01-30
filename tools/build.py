import os
from pathlib import Path
import json
from sqf_validator import main as validator
from libbuild import preprocess, build_composition

os.chdir(Path(__file__).parent)
with open('../meta.json', 'r') as stream:
    meta_data = json.load(stream)

src_root = Path('../components')
tpl_root = Path('../composition')
build_root = Path('../build')

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
    build_composition(body, build_root=build_root, tpl_root=tpl_root, meta_data=meta_data)
    print(f'Build completed!')
