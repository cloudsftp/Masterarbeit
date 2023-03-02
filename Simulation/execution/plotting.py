#!/usr/bin/env python

from __future__ import annotations
from textwrap import dedent
import subprocess
import shutil

from util.output import info
from util.exceptions import CustomException
from util.execution import execute_and_wait
from configuration.diagrams import DiagramType
from execution import frame
from execution.ant import get_data_file_paths

def generate_picture(frame):
    create_gnuplot_program(frame)
    run_gnuplot_program(frame)

    if not frame.diagram.options.simple_figure: 
        frag(frame)
        crop(frame)
        convert(frame)

# Gnuplot plotting

def create_gnuplot_program(frame: frame.Frame):
    info(f'Generating {get_gnuplot_file_path(frame)}')

    with get_gnuplot_file_path(frame).open('w') as gnuplot_file:
        gnuplot_file.write(gnuplot_start(frame))
        gnuplot_file.write(dimensions(frame))
        gnuplot_file.write(tics(frame))
        
        gnuplot_file.write(extras(frame))
        gnuplot_file.write(plot_commands(frame))


def gnuplot_start(frame: frame.Frame) -> str:
    res = dedent(f'''
        reset
        set loadpath '{frame.diagram.path}' '{frame.diagram.model.path}'
        ''')
            
    for name in frame.parameters:
        res += f'{name} = {frame.parameters[name]}\n'

    if frame.diagram.options.simple_figure:
        res += dedent(f'''
            set terminal png
            set output '{get_simple_result_png_path(frame)}'
            ''')
    else:
        res += dedent(f'''
            set terminal postscript landscape enhanced color blacktext \\
               dashed dashlength 1.0 linewidth 1.0 defaultplex \\
               palfuncparam 2000,0.003 \\
               butt "Helvetica" 20
            set output "{get_result_eps_path(frame)}"
            ''')

    res += dedent(f'''
        set size square
        set border lw 1
        ''')

    return res

def dimensions(frame: frame.Frame):
    if frame.diagram.L == None or frame.diagram.R == None \
        or frame.diagram.D == None or frame.diagram.U == None:

        if frame.diagram.type == DiagramType.PERIOD:
            if not frame.scan:
                raise CustomException('Diagram of type period should have at least one scan dimension')

            L = frame.scan[0].parameter_specs[0].start
            R = frame.scan[0].parameter_specs[0].stop

            if len(frame.scan) > 1:
                D = frame.scan[1].parameter_specs[0].start
                U = frame.scan[1].parameter_specs[0].stop

            else:
                D = 0
                U = frame.diagram.max_periods
        
        elif frame.diagram.type == DiagramType.PERIOD_REGIONS:
            if not frame.scan or len(frame.scan) != 2:
                raise CustomException('Diagram of type period regions should have two scan dimension')
            
            L = frame.scan[0].parameter_specs[0].start
            R = frame.scan[0].parameter_specs[0].stop

            D = frame.scan[1].parameter_specs[0].start
            U = frame.scan[1].parameter_specs[0].stop
        
        elif frame.diagram.type == DiagramType.BIFURCATION:
            L = frame.scan[0].parameter_specs[0].start
            R = frame.scan[0].parameter_specs[0].stop
            
            D = frame.scan[-1].parameter_specs[0].start
            U = frame.scan[-1].parameter_specs[0].stop * 2 # TODO: better solution
        
        elif frame.diagram.type == DiagramType.COBWEB:
            raise CustomException(f'You need to define L, R, D, and U in {frame.diagram.config_file_path} for diagram type cobweb')

        else:
            raise CustomException('Only diagram type period, period region, and cobweb figures supported!')

    else:
        L = frame.diagram.L
        R = frame.diagram.R
        D = frame.diagram.D
        U = frame.diagram.U
    
    return dedent(f'''
        L = {L}
        R = {R}
        D = {D}
        U = {U}

        set xrange [L to R]
        set yrange [D to U]
        ''')

def tics(frame: frame.Frame) -> str:
    if not frame.diagram.options.simple_figure:
        return dedent(f'''
        set xtics ('L' L, 'R' R)
        set ytics ('D' D, 'U' U) rotate by 90

        set xlabel 'x' offset 0, 1.3
        set ylabel 'y' offset 4.2, 0 rotate by 90
        ''')
        
    x_label = 'x'
    y_label = 'y'

    if frame.diagram.options.simple_figure:
        if frame.diagram.type == DiagramType.PERIOD:
            x_label = frame.scan[0].parameter_specs[0].name

            if len(frame.scan) == 1:
                y_label = 'Period'

            elif len(frame.scan) == 2:
                y_label = frame.scan[1].parameter_specs[0].name
            
        elif frame.diagram.type == DiagramType.PERIOD_REGIONS:
            x_label = frame.scan[0].parameter_specs[0].name
            y_label = frame.scan[1].parameter_specs[0].name
    
    return  dedent(f'''
        set xlabel '{x_label}'
        set ylabel '{y_label}'
        ''')
    

def extras(frame: frame.Frame) -> str:
    if get_gnuplot_extras_path(frame).exists():
        return dedent(f'''
            load '{get_gnuplot_extras_path(frame)}'
            ''')
    else:
        return ''

def plot_commands(frame: frame.Frame) -> str:
    if frame.diagram.type == DiagramType.PERIOD:
        x = 1
        y = x + len(frame.scan[0].parameter_specs)
        if len(frame.scan) == 1:
            return dedent(f'''
                plot '{get_data_file_paths(frame)[0]}' using {x}:{y} w dots notitle lc rgb 'blue'
                ''')
        elif len(frame.scan) == 2:
            z = y + len(frame.scan[1].parameter_specs)
            return dedent(f'''
                unset colorbox
                set palette rgbformulae 30,31,32
                plot '{get_data_file_paths(frame)[0]}' using {x}:{y}:{z} w dots notitle palette
                ''')

    elif frame.diagram.type == DiagramType.COBWEB:
        if get_gnuplot_model_path(frame).exists():
            res = dedent(f'''
                load '{get_gnuplot_model_path(frame)}'

                plot f(x) w points ps 0.3 pt 7 lc rgb 'black' notitle, \\
                ''')
            
        else:
            res = dedent(f'''
                plot '{get_gnuplot_model_data_path(frame)}' w points ps 0.3 pt 7 lc rgb 'black' notitle, \\
                ''')
        
        res += f'''\\
            '{get_data_file_paths(frame)[0]}' w lines lw 1 lc rgb 'red' notitle, \\
            x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
            '''
        return res

    elif frame.diagram.type == DiagramType.BIFURCATION:
        x = 1
        y = x + sum(len(s.parameter_specs) for s in frame.scan)
        return dedent(f'''
            plot '{get_data_file_paths(frame)[0]}' using {x}:{y} w dots notitle lc rgb 'blue'
            ''')

    else:
        raise CustomException(f'Not yet implemented for diagram type {frame.diagram.type}')

def run_gnuplot_program(frame: frame.Frame):
    info(f'Executing {get_gnuplot_file_path(frame)}')
    execute_and_wait(['gnuplot', f'{get_gnuplot_file_path(frame)}'], frame.path)

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
        info(f'Copying {diagram_fm_path} to current frame')
        shutil.copy(diagram_fm_path, frame_fm_path)
    
    info('Executing fragmaster')
    execute_and_wait(['fragmaster'], frame.path)

def crop(frame: frame.Frame):
    result_pdf_path = get_result_pdf_path(frame)

    info(f'Cropping {result_pdf_path}')
    execute_and_wait(['pdfcrop'] + 2 * [str(result_pdf_path)], frame.path)

def convert(frame: frame.Frame):
    result_pdf_path = get_result_pdf_path(frame)
    result_png_path = get_result_png_path(frame)

    info(f'Converting {result_pdf_path} to {result_png_path}')
    execute_and_wait([
        'convert',
        '-rotate', '90',
        '-density', '600',
        '-alpha', 'off',
        str(result_pdf_path), str(result_png_path),
    ], frame.path)

# Path utils

def get_result_eps_path(frame: frame.Frame) -> Path:
    return frame.path / 'result_fm.eps'

def get_result_pdf_path(frame: frame.Frame) -> Path:
    return frame.path / 'result.pdf'

def get_result_png_path(frame: frame.Frame) -> Path:
    return frame.path / 'result.png'

def get_simple_result_png_path(frame: frame.Frame) -> Path:
    return frame.path / 'result-simple.png'

def get_gnuplot_file_path(frame: execution.frame.Frame) -> Path:
    return frame.path / 'plot.plt'

def get_gnuplot_dimens_path(frame: frame.Frame) -> Path:
    return frame.diagram.path / 'dimens.plt'

def get_gnuplot_extras_path(frame: frame.Frame) -> Path:
    return frame.diagram.path / 'extras.plt'

def get_gnuplot_model_path(frame: frame.Frame) -> Path:
    return frame.diagram.model.path / 'model.plt'

def get_gnuplot_model_generation_path(frame: frame.Frame) -> Path:
    return frame.diagram.model.path / 'model.py'

def get_gnuplot_model_data_path(frame: frame.Frame) -> Path:
    return frame.path / 'model.dat'

def get_diagram_fm_path(frame: frame.Frame) -> Path:
    return frame.diagram.path / 'result_fm'

def get_frame_fm_path(frame: frame.Frame) -> Path:
    return frame.path / 'result_fm'
