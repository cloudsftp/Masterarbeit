#!/usr/bin/env python

from typing import Dict, List
from dataclasses import dataclass
from os import path
import json

@dataclass
class Parameter(object):
    name: str
    default: float

class Model(object):
    path: str
    num_parameters: int
    parameters: List[Parameter]

    def __init__(self, model_path):
        self.path = model_path
        config_file_path: str = path.join(model_path, 'model.json')
            
        with open(config_file_path) as config_file:
            config: Dict[str, Any] = json.load(config_file)
            
            if not 'parameters' in config:
                raise Exception(f'"parameters" missing in {config_file}')
            
            parameters = config['parameters']
            if not isinstance(parameters, list):
                raise Exception(f'"parameters" in {config_file} should be a list')
            
            self.num_parameters = len(parameters)
            self.parameters = []
            for parameter in parameters:
                if len(parameter) != 1:
                    raise Exception(f'Parameter {parameter} should only have one entry')

                for name in parameter:
                    self.parameters.append(Parameter(name, parameter[name]))
    
