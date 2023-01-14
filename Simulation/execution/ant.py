#1/usr/bin/env python

from __future__ import annotations

from execution import frame
from util.file import is_outdated
from util.output import info

def generate_ant_config_file(frame: frame.Frame):
    if not is_outdated(frame.config_file_path, frame.diagram.config_file_path, frame.diagram.model.config_file_path):
        info(f'Skipping generation of AnT config file "{frame.config_file_path}"')
        # return
    
    with frame.config_file_path.open('w') as ant_config_file:
        ant_config_file.write(config_file_start(frame))
        
        ant_config_file.write(config_file_parameters(frame))



def config_file_start(frame: frame.Frame) -> str:
    return f'''dynamical_system = {{
    type = map,
    name = "map",
    parameter_space_dimension = {len(frame.parameters)},
'''

def config_file_parameters(frame: frame.Frame) -> str:
    res = '    parameters = {\n'

    cnt = 0
    for name in frame.parameters:
        res += f'''        parameter[{cnt}] = {{
            name = "{name}",
            value = {frame.parameters[name]}
        }},
'''
        cnt += 1

    res = res[:-2]
    res += '\n    },'
    
    return res
