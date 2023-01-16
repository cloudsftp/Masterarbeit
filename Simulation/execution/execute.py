#!/usr/bin/env python

import shutil
from pathlib import Path

from util.exceptions import CustomException
from util.execution import execute_and_wait
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
        raise CustomException('Animations not yet implemented!')

def show_pic(pic_path: Path):
    execute_and_wait(['imv', str(pic_path)])

# Path utils

def get_final_result_png_path(diagram: Diagram) -> Path:
    return diagram.path / 'result.png'
