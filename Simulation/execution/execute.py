#!/usr/bin/env python

import shutil
from pathlib import Path
from copy import copy
from typing import List

from util.exceptions import CustomException
from util.execution import execute_and_wait
from util.ranges import generate_parameters_for_animation
from configuration.diagrams import (
    Diagram,
    DiagramType,
    invert_parameter_ranges,
    invert_scan,
)
from execution.frame import Frame
from execution.plotting import get_result_png_path, get_simple_result_png_path
from execution.composite_plotting import generate_composite_picture
from execution import composite_plotting
from execution.symbolic import process_simple_symbolic


def generate_diagram(diagram: Diagram):
    if diagram.animation:
        generate_animated_diagram(diagram)

    elif diagram.type == DiagramType.PERIOD_REGIONS:
        generate_regions_diagram(diagram)

    else:
        generate_simple_diagram(diagram)


def generate_simple_diagram(diagram: Diagram):
    frame = Frame(diagram, 0)
    frame.run()

    if diagram.type == DiagramType.ANALYSIS:
        return

    if diagram.type == DiagramType.COBWEB:
        process_simple_symbolic(frame)

    if diagram.options.simple_figure:
        final_result_png_path = get_final_simple_result_png_path(diagram)
        result_png_path = get_simple_result_png_path(frame)
    else:
        final_result_png_path = get_final_result_png_path(diagram)
        result_png_path = get_result_png_path(frame)

    shutil.copy(result_png_path, final_result_png_path)
    if not diagram.options.dont_show:
        show_pic(result_png_path)


def generate_regions_diagram(diagram: Diagram):
    frames = [
        Frame(diagram, 0),
        Frame(diagram, 1, scan=invert_parameter_ranges(diagram.scan, 0)),
        Frame(diagram, 2, scan=invert_scan(diagram.scan)),
        Frame(diagram, 3, scan=invert_scan(invert_parameter_ranges(diagram.scan, 1))),
    ]

    for frame in frames:
        frame.run()

    generate_composite_picture(frames)

    if diagram.options.simple_figure:
        final_result_png_path = get_final_simple_result_png_path(diagram)
        result_png_path = composite_plotting.get_simple_result_png_path(diagram)
    else:
        final_result_png_path = get_final_result_png_path(diagram)
        result_png_path = composite_plotting.get_result_png_path(diagram)

    shutil.copy(result_png_path, final_result_png_path)
    if not diagram.options.dont_show:
        show_pic(result_png_path)


def generate_animated_diagram(diagram: Diagram):
    cnt = 0
    frames = []
    for parameters in generate_parameters_for_animation(diagram.animation):
        frames.append(Frame(diagram, cnt, parameters))
        cnt += 1

    for frame in frames:
        frame.run()

    if diagram.type == DiagramType.ANALYSIS:
        return

    synthesize_gif(diagram, frames)

    if not diagram.options.dont_show:
        show_pic(get_final_result_gif_path(diagram))


def synthesize_gif(diagram: Diagram, frames: List[Frame]):
    args = [
        "convert",
        "-delay",
        str(50),
        "-loop",
        "0",
    ]

    for frame in frames:
        if diagram.options.simple_figure:
            path = get_simple_result_png_path(frame)
        else:
            path = get_result_png_path(frame)
        args.append(str(path))

    args.append(str(get_final_result_gif_path(diagram)))

    execute_and_wait(args)

    """
    execute_and_wait([
        'gifsicle',
        '-i', str(get_final_result_gif_path(diagram)),
        '-O3',
        '--colors', '16',
        '-o', str(get_final_result_gif_path(diagram)),
    ])
    """


def show_pic(pic_path: Path):
    execute_and_wait(["imv", str(pic_path)])


# Path utils


def get_final_result_png_path(diagram: Diagram) -> Path:
    return diagram.path / "result.png"


def get_final_simple_result_png_path(diagram: Diagram) -> Path:
    return diagram.path / "result-simple.png"


def get_final_result_gif_path(diagram: Diagram) -> Path:
    return diagram.path / "result.gif"
