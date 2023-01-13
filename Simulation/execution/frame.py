#!/usr/bin/env python

from typing import List, Dict, Optional
from pathlib import Path

from util.file import is_outdated
from util.output import info
from configuration.models import Parameters, join_parameters
from configuration.diagrams import Diagram

class Frame:
    diagram: Diagram

    path: Path
    config_file_path: Path
    parameters: Parameters
    
    def __init__(self, diagram: Diagram, id: int, parameters: Optional[Parameters] = None):
        self.diagram = diagram

        self.path = diagram.path / f'Frame_{id:04d}'
        self.config_file_path = self.path / 'config.ant'
        
        if parameters:
            self.parameters = join_parameters(diagram.parameters, parameters)
        else:
            self.parameters = diagram.parameters
            
    def run(self):
        self.path.mkdir(exist_ok=True)

        generate_ant_config_file(self)



def generate_ant_config_file(frame: Frame):
    if not is_outdated(frame.config_file_path, frame.diagram.config_file_path, frame.diagram.model.config_file_path):
        info(f'Skipping generation of AnT config file "{frame.config_file_path}"')
    
    with frame.config_file_path.open('w') as ant_config_file:
        ant_config_file.write(
f'''dynamical_system = {{
    type = map,
    name = "map",
    parameter_space_dimension = {len(frame.parameters)},'''
        )


