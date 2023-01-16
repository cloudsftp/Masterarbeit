#!/usr/bin/env python

from __future__ import annotations
import subprocess

from util.file import is_outdated
from util.output import info
from util.exceptions import CustomException
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
    run_gnuplot_program(frame)
    
    frag(frame)
    crop(frame)
    convert(frame)

def create_gnuplot_program(frame: frame.Frame):
    info(f'Generating {get_gnuplot_file_path(frame)}')

    with get_gnuplot_file_path(frame).open('w') as gnuplot_file:
        gnuplot_file.write(gnuplot_start(frame))
        gnuplot_file.write(dimensions(frame))
        gnuplot_file.write(range_and_tics())
        
        gnuplot_file.write(extras(frame))
        gnuplot_file.write(plot_commands(frame))


def gnuplot_start(frame: frame.Frame) -> str:
    return f'''
reset
set loadpath '{frame.diagram.path}' '{frame.diagram.model.path}'

set terminal postscript landscape enhanced color blacktext \\
   dashed dashlength 1.0 linewidth 1.0 defaultplex \\
   palfuncparam 2000,0.003 \\
   butt "Helvetica" 20

set size square

set output "{get_result_eps_path(frame)}"

set border lw 1
'''

def dimensions(frame: frame.Frame):
    res = ''

    if frame.diagram.type == DiagramType.PERIOD:
        if not frame.diagram.scan:
            raise CustomException('Diagram of type period should have at least one scan dimension')

        res += f'''
L = {frame.diagram.scan[0].parameter_specs[0].start}
R = {frame.diagram.scan[0].parameter_specs[0].stop}
'''

        if len(frame.diagram.scan) > 1:
            res += f'''
D = {frame.diagram.scan[1].parameter_specs[0].start}
U = {frame.diagram.scan[1].parameter_specs[0].stop}
'''
        else:
            res += f'''
D = 0
U = {frame.diagram.max_periods}
'''

    else:
        raise CustomException('Only diagram type period figures supported!')
    
    if get_gnuplot_dimens_path(frame).exists():
        res += f'''
load '{get_gnuplot_dimens_path(frame)}'
'''

    return res

def range_and_tics() -> str:
    return '''
set xrange [L to R]
set yrange [D to U]

set xtics ("L" L, "R" R) offset 0, -0.2
set ytics ("D" D, "U" U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90
'''

def extras(frame: frame.Frame) -> str:
    if get_gnuplot_extras_path(frame).exists():
        return f'''
load '{get_gnuplot_extras_path(frame)}'    
'''
    else:
        return ''

def plot_commands(frame: frame.Frame) -> str:
    if frame.diagram.type == DiagramType.PERIOD:
        if len(frame.diagram.scan) == 1:
            raise CustomException('Period figure for one dimension not yet implemented')
            return f'''

'''
        elif len(frame.diagram.scan) == 2:
            return f'''
unset colorbox

set palette rgbformulae 30,31,32

plot '{get_data_file_path(frame)} w dots notitle palette
'''

    else:
        raise CustomException(f'Not yet implemented for diagram type {frame.diagram.type}')

def run_gnuplot_program(frame: frame.Frame):
    info(f'Executing {get_gnuplot_file_path(frame)}')
    execute_and_wait(['gnuplot', f'{get_gnuplot_file_path(frame)}'], frame)

# Post processing

def frag(frame: frame.Frame):
    diagram_fm_path = get_diagram_fm_path(frame)
    frame_fm_path = get_frame_fm_path(frame)

    if not diagram_fm_path.exists():
        info(f'No file {diagram_fm_path}')
        info(f'Generating empty file {frame_fm_path}')

        with frame_fm_path.open('w') as fm_file:
            fm_file.write('%% fmopt: width=8cm\n')
        
    else:
        raise CustomException('fm files not supported yet')
    
    info('Executing fragmaster')
    execute_and_wait(['fragmaster'], frame)

def crop(frame: frame.Frame):
    result_pdf_path = get_result_pdf_path(frame)

    info(f'Cropping {result_pdf_path}')
    execute_and_wait(['pdfcrop'] + 2 * [str(result_pdf_path)], frame)

def convert(frame: frame.Frame):
    result_pdf_path = get_result_pdf_path(frame)
    result_png_path = get_result_png_path(frame)

    info(f'Coverting {result_pdf_path} to {result_png_path}')
    execute_and_wait([
        'convert',
        '-rotate', '90',
        '-density', '600',
        '-alpha', 'off',
        str(result_pdf_path), str(result_png_path),
    ], frame)

# Execution utils

def execute_and_wait(args: List[str], frame: frame.Frame):
    process = subprocess.run(
        args,
        cwd = frame.path,
        stdout = subprocess.PIPE,
        stderr = subprocess.STDOUT,
    )
    
    if process.returncode > 0:
        if process.stdout:
            print()
            print(process.stdout.decode())

        raise CustomException(f'Problem while executing {args[0]}')

# Path utils

def get_result_eps_path(frame: frame.Frame) -> Path:
    return frame.path / 'result_fm.eps'

def get_result_pdf_path(frame: frame.Frame) -> Path:
    return frame.path / 'result.pdf'

def get_result_png_path(frame: frame.Frame) -> Path:
    return frame.path / 'result.png'

def get_gnuplot_file_path(frame: execution.frame.Frame) -> Path:
    return frame.path / 'plot.plt'

def get_gnuplot_dimens_path(frame: frame.Frame) -> Path:
    return frame.diagram.path / 'dimens.plt'

def get_gnuplot_extras_path(frame: frame.Frame) -> Path:
    return frame.diagram.path / 'extras.plt'

def get_diagram_fm_path(frame: frame.Frame) -> Path:
    return frame.diagram.path / 'result_fm'

def get_frame_fm_path(frame: frame.Frame) -> Path:
    return frame.path / 'result_fm'
