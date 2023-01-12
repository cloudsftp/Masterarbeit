#!/usr/bin/env python

from typing import Dict, List
from dataclasses import dataclass
from pathlib import Path
import json
import subprocess

from util.file import is_outdated
from util.execute import build_system
from util.output import info

@dataclass
class Parameter(object):
    name: str
    default: float

class Model(object):
    path: Path
    num_parameters: int
    parameters: List[Parameter]

    def __init__(self, model_path: Path):
        self.path = model_path
        config_file_path: Path = model_path / 'model.json'
            
        with config_file_path.open() as config_file:
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
    
    def compile(self):
        model_target_file_path: Path = self.path / 'model.so'
        model_source_file_path: Path = self.path / 'model.cpp'

        if is_outdated(model_target_file_path, model_source_file_path):
            info(f'Compiling {model_source_file_path}...')
            compile_proc: subprocess.CompletedProcess = subprocess.run(
                str(build_system),
                cwd=self.path,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.PIPE,
            )
            
            if compile_proc.returncode != 0:
                print(compile_proc.stderr.decode())
                print()

                raise Exception(f'Could not compile {model_source_file_path}')
            
            info('Done\n')
        
        else:
            info(f'Not compiling {model_source_file_path}, since it has already been compiled\n')

