#!/usr/bin/env python

from typing import Dict, List, Union, Any, Optional
from dataclasses import dataclass
from pathlib import Path
import json
import subprocess
import os

from util.file import is_outdated
from util.paths import build_system, ant_executable_path
from util.output import info
from util.exceptions import CustomException

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

        if not is_outdated(self.library_file_path, model_source_file_path):
            info(f'Skipping compilation of {model_source_file_path}')
            
        env = os.environ.copy()
        env['PATH'] = str(ant_executable_path) + ':' + env['PATH']

        info(f'Compiling {model_source_file_path}...')
        compile_proc: subprocess.CompletedProcess = subprocess.run(
            str(build_system),
            cwd=self.path,
            env = env,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
        )
        
        if compile_proc.returncode != 0:
            print(compile_proc.stderr.decode())
            print()

            raise CustomException(f'Could not compile {model_source_file_path}')
        
        info('Done')
        









def load_model_from_dict(
    obj: Model,
    config: Union[Dict[str, Any], Any],
):
    if not isinstance(config, dict):
        raise CustomException('Model configuration should be dict')

    if not 'parameters' in config:
        raise CustomException(f'"parameters" missing in model configuration')
    
    parameters = config['parameters']
    if not isinstance(parameters, dict):
        raise CustomException('"parameters" in model config file should be a dict')
    
    for name in parameters:
        if not (isinstance(parameters[name], float) or isinstance(parameters[name], int)):
            raise CustomException(f'Parameter {name} in model config file should be float or int')
    
    obj.parameters = parameters
