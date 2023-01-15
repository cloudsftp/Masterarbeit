#!/usr/bin/env python

from __future__ import annotations

from execution import frame
from util.file import is_outdated
from util.output import info
from execution.ant import get_data_file_path

def generate_picture(frame):
    generate_simple_picture(frame)

# Gnuplot plotting

def generate_simple_picture(frame: frame.Frame):
    result_eps_path = get_result_eps_path(frame)
    gnuplot_file_path = get_gnuplot_file_path(frame)

    if not is_outdated(result_eps_path, get_data_file_path(frame)):
        info(f'Skipping generation of {result_eps_path}')
        return

    print('yes')


def get_result_eps_path(frame: frame.Frame) -> Path:
    return frame.path / 'result.eps'

def get_gnuplot_file_path(frame: execution.frame.Frame) -> Path:
    return frame.path / 'plot.plt'
