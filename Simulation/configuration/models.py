#!/usr/bin/env python

from typing import Dict, List, Union, Any, Optional
from dataclasses import dataclass
from pathlib import Path
import json
import subprocess

from util.file import is_outdated
from util.execute import build_system
from util.output import info

Parameters = Dict[str, Union[float, int]]

def join_parameters(old: Parameters, new: Parameters) -> Parameters:
    copy = old.copy()
    copy.update(new)
    return copy


class Model(object):
    path: Path
    config_file_path: Path
    library_file_path: Path
    parameters: Parameters

    def __init__(self, model_path: Path):
        self.path = model_path
        self.config_file_path: Path = model_path / 'model.json'
            
        with self.config_file_path.open() as config_file:
            config: Union[Dict[str, Any], Any] = json.load(config_file)
            
            load_model_from_dict(self, config)
    
    def compile(self):
        self.library_file_path: Path = self.path / 'model.so'
        model_source_file_path: Path = self.path / 'model.cpp'

        if is_outdated(self.library_file_path, model_source_file_path):
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










def load_model_from_dict(
    obj: Model,
    config: Union[Dict[str, Any], Any],
):
    if not isinstance(config, dict):
        raise Exception('Model configuration should be dict')

    if not 'parameters' in config:
        raise Exception(f'"parameters" missing in model configuration')
    
    parameters = config['parameters']
    if not isinstance(parameters, dict):
        raise Exception('"parameters" in model config file should be a dict')
    
    for name in parameters:
        if not (isinstance(parameters[name], float) or isinstance(parameters[name], int)):
            raise Exception(f'Parameter {name} in model config file should be float or int')
    
    obj.parameters = parameters
