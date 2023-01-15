#!/usr/bin/env python

from __future__ import annotations

from util.file import is_outdated
from util.output import info
from configuration.diagrams import DiagramType
from execution import frame
from execution.ant import get_data_file_path

def generate_picture(frame):
    generate_simple_picture(frame)

# Gnuplot plotting

def generate_simple_picture(frame: frame.Frame):
    result_eps_path = get_result_eps_path(frame)
    gnuplot_file_path = get_gnuplot_file_path(frame)

    if not is_outdated(result_eps_path, get_data_file_path(frame)):
        info(f'Skipping generation of {result_eps_path}')
        # return

    info(f'Generating {result_eps_path}')
    create_gnuplot_program(frame)

def create_gnuplot_program(frame: frame.Frame):
    with get_gnuplot_file_path(frame).open('w') as gnuplot_file:
        gnuplot_file.write(gnuplot_start(frame))
        gnuplot_file.write(dimensions(frame))


def gnuplot_start(frame: frame.Frame) -> str:
    return f'''
reset
set loadpath {frame.diagram.path} {frame.diagram.model.path}

set terminal postscript landscape enhanced color blacktext \\
   dashed dashlength 1.0 linewidth 1.0 defaultplex \\
   palfuncparam 2000,0.003 \\
   butt "Helvetica" 20
   
set output "{get_result_eps_path(frame)}"

set border lw 1
'''

def dimensions(frame: frame.Frame):
    res = ''

    if frame.diagram.type == DiagramType.PERIOD:
        if not frame.diagram.scan:
            raise Exception('Diagram of type period should have at least one scan dimension')

        res += f'''
L = {frame.diagram.scan[0].parameter_specs[0].start}
R = {frame.diagram.scan[0].parameter_specs[0].stop}
'''

        if len(frame.diagram.scan) > 1:
            res += f'''
D = {frame.diagram.scan[1].parameter_specs[0].start}
R = {frame.diagram.scan[1].parameter_specs[0].stop}
'''
        else:
            res += f'''
D = 0
U = {frame.diagram.max_periods}
'''

    else:
        raise Exception('Only diagram type period figures supported!')

    return res


# Path utils

def get_result_eps_path(frame: frame.Frame) -> Path:
    return frame.path / 'result.eps'

def get_gnuplot_file_path(frame: execution.frame.Frame) -> Path:
    return frame.path / 'plot.plt'
