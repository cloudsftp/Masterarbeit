#!/usr/bin/env python

from typing import List, Dict, Optional
from pathlib import Path

from configuration.models import Parameters, join_parameters
from configuration.diagrams import Diagram

class Frame:
    diagram: Diagram

    path: Path
    config_file: Path
    parameters: Parameters
    
    def __init__(self, diagram: Diagram, id: int, parameters: Optional[Parameters] = None):
        self.path = diagram.path / f'Frame_{id:04d}'
        self.config_file = self.path / 'config.ant'
        
        if parameters:
            self.parameters = join_parameters(diagram.parameters, parameters)
