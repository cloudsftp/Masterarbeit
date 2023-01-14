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
        ant_config_file.write(
f'''dynamical_system = {{
    type = map,
    name = "map",
    parameter_space_dimension = {len(frame.parameters)},'''
        )