#!/usr/bin/env python

from typing import List, Dict, Optional
from pathlib import Path

from util.file import is_outdated
from util.output import info
from configuration.models import Parameters, join_parameters
from configuration.diagrams import Diagram
from configuration.ant import generate_ant_config_file
from execution.ant import execute_simulation

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
        execute_simulation(self)


