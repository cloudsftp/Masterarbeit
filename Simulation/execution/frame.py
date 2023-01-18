#!/usr/bin/env python

from typing import List, Dict, Optional
from pathlib import Path
import subprocess

from util.file import is_outdated
from util.output import info
from util.exceptions import CustomException
from util.execution import execute_and_wait
from configuration.models import Parameters, join_parameters
from configuration.diagrams import Diagram, DiagramType
from configuration.ant import generate_ant_config_file
from execution.ant import execute_simulation
from execution.plotting import generate_picture, get_gnuplot_model_generation_path, get_gnuplot_model_data_path, get_gnuplot_model_path

class Frame:
    diagram: Diagram

    path: Path
    config_file_path: Path
    parameters: Parameters
    
    def __init__(self, diagram: Diagram, id: int, parameters: Optional[Parameters] = None):
        self.diagram = diagram

        self.path = diagram.path / 'Autogen' / f'Frame_{id:04d}'
        self.config_file_path = self.path / 'config.ant'
        
        if parameters:
            self.parameters = join_parameters(diagram.parameters, parameters)
        else:
            self.parameters = diagram.parameters
            
    def run(self):
        self.path.mkdir(parents=True, exist_ok=True)

        generate_ant_config_file(self)
        execute_simulation(self)
        generate_function_data(self)
        generate_picture(self)

# Generating the function data for cobwebs

def generate_function_data(frame: Frame):
    if frame.diagram.type != DiagramType.COBWEB or get_gnuplot_model_path(frame).exists():
        return

    data_path = get_gnuplot_model_data_path(frame)
    model_gen_path = get_gnuplot_model_generation_path(frame)
    
    if not model_gen_path.exists():
        raise CustomException(f'{model_gen_path} missing')
    
    if not is_outdated(data_path, model_gen_path, frame.diagram.config_file_path, frame.diagram.model.config_file_path):
        info(f'Skipping generation of {data_path}')
        return

    info(f'Generating {data_path}')

    args = [
        'python',
        str(get_gnuplot_model_generation_path(frame)),
    ]

    for name in frame.parameters:
        args += [f'--{name}', str(frame.parameters[name])]
    
    args += [
        '--start', str(frame.diagram.L),
        '--end', str(frame.diagram.R),
        '--resolution', str(3000)
    ]

    process = execute_and_wait(args)
    
    with data_path.open('w') as data_file:
        data_file.write(process.stdout.decode())
    
