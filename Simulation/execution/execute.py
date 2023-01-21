#!/usr/bin/env python

import shutil
from pathlib import Path
from copy import copy
from typing import List

from util.exceptions import CustomException
from util.execution import execute_and_wait
from util.ranges import generate_parameters_for_animation
from configuration.diagrams import Diagram
from execution.frame import Frame
from execution.plotting import get_result_png_path, get_simple_result_png_path

def generate_diagram(diagram: Diagram):
    if not diagram.animation:
        frame = Frame(diagram, 0)
        frame.run()
        
        if diagram.options.simple_figure:
            show_pic(get_simple_result_png_path(frame))

        else:
            result_png_path = get_final_result_png_path(diagram)
            shutil.copy(get_result_png_path(frame), result_png_path)
            show_pic(result_png_path)
    
    else:
        cnt = 0
        frames = []
        for parameters in generate_parameters_for_animation(diagram.animation):
            frames.append(Frame(diagram, cnt, parameters))
            cnt += 1
        
        for frame in frames:
            frame.run()
        
        synthesize_gif(diagram, frames)
        
        show_pic(get_final_result_gif_path(diagram))

def synthesize_gif(diagram: Diagram, frames: List[Frame]):
    args = [
        'convert',
        '-delay', str(50),
        '-loop', '0',
    ]

    for frame in frames:
        if diagram.options.simple_figure:
            path = get_simple_result_png_path(frame)
        else:
            path = get_result_png_path(frame)
        args.append(str(path))
    
    args.append(str(get_final_result_gif_path(diagram)))
    
    execute_and_wait(args)
    
    '''
    execute_and_wait([
        'gifsicle',
        '-i', str(get_final_result_gif_path(diagram)),
        '-O3',
        '--colors', '16',
        '-o', str(get_final_result_gif_path(diagram)),
    ])
    '''

def show_pic(pic_path: Path):
    execute_and_wait(['imv', str(pic_path)])

# Path utils

def get_final_result_png_path(diagram: Diagram) -> Path:
    return diagram.path / 'result.png'

def get_final_result_gif_path(diagram: Diagram) -> Path:
    return diagram.path / 'result.gif'
