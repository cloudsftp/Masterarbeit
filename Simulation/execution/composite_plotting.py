#!/usr/bin/env python

from __future__ import annotations
from textwrap import dedent
import subprocess
import shutil

from util.output import info
from util.exceptions import CustomException
from util.execution import execute_and_wait
from configuration.diagrams import Diagram, DiagramType
from execution import frame
from execution.ant import get_data_file_paths
from execution.plotting import gnuplot_start, dimensions, tics, extras


def generate_composite_picture(frames: List[frame.Frame]):
    diagram = frames[0].diagram

    generate_composite_gnuplot_program(frames)
    run_composite_gnuplot_program(diagram)

    if not diagram.options.simple_figure:
        frag_composite(diagram)
        crop_composite(diagram)
        convert_composite(diagram)


# Gnuplot plotting


def generate_composite_gnuplot_program(frames: List[Frame]):
    diagram = frames[0].diagram
    info(f"Generating {get_gnuplot_file_path(diagram)}")

    with get_gnuplot_file_path(diagram).open("w") as gnuplot_file:
        gnuplot_file.write(gnuplot_start(frames[0]))
        gnuplot_file.write(different_output(diagram))
        gnuplot_file.write(dimensions(frames[0]))
        gnuplot_file.write(tics(frames[0]))

        gnuplot_file.write(extras(frames[0]))
        gnuplot_file.write(gnuplot_commands(frames))


def different_output(diagram: Diagram) -> str:
    if diagram.options.simple_figure:
        output_path = get_simple_result_png_path(diagram)
    else:
        output_path = get_result_eps_path(diagram)

    return dedent(
        f"""
        set output '{output_path}'
        """
    )


def gnuplot_commands(frames: List[frame.Frame]) -> str:
    if frames[0].diagram.type == DiagramType.PERIOD_REGIONS:
        if len(frames) == 4:
            return dedent(
                f"""
                plot '{get_data_file_paths(frames[0])[0]}' w dots lc rgb 'orange' notitle, \\
                    '{get_data_file_paths(frames[1])[0]}' w dots lc rgb 'purple' notitle, \\
                    '{get_data_file_paths(frames[2])[0]}' u 2:1 w dots lc rgb 'blue' notitle, \\
                    '{get_data_file_paths(frames[3])[0]}' u 2:1 w dots lc rgb 'red' notitle
                """
            )

        elif len(frames) == 2:
            return dedent(
                f"""
                plot '{get_data_file_paths(frames[0])[0]}' w dots lc rgb 'blue' notitle, \\
                    '{get_data_file_paths(frames[1])[0]}' w dots lc rgb 'red' notitle
                """
            )

        else:

            raise CustomException(
                f"Wrong number of frames for period regions. Has to be either 2 or 4"
            )

    elif frames[0].diagram.type == DiagramType.BIFURCATION_MULTICOLOR:
        if len(frames) == 2:
            return dedent(
                f"""
                plot '{get_data_file_paths(frames[0])[0]}' w dots lc rgb 'red' notitle, \\
                    '{get_data_file_paths(frames[1])[0]}' w dots lc rgb 'blue' notitle
                """
            )


def run_composite_gnuplot_program(diagram: Diagram):
    info(f"Executing {get_gnuplot_file_path(diagram)}")
    execute_and_wait(
        ["gnuplot", str(get_gnuplot_file_path(diagram))], get_autogen_path(diagram)
    )


# Post processing


def frag_composite(diagram: Diagram):
    diagram_fm_path = get_diagram_fm_path(diagram)
    frame_fm_path = get_frame_fm_path(diagram)

    if not diagram_fm_path.exists():
        info(f"No file {diagram_fm_path}")
        info(f"Generating empty file {frame_fm_path}")

        with frame_fm_path.open("w") as fm_file:
            fm_file.write("%% fmopt: width=8cm\n")

    else:
        info(f"Copying {diagram_fm_path} to current frame")
        shutil.copy(diagram_fm_path, frame_fm_path)

    info("Executing fragmaster")
    execute_and_wait(["fragmaster"], get_autogen_path(diagram))


def crop_composite(diagram: Diagram):
    result_pdf_path = get_result_pdf_path(diagram)

    info(f"Cropping {result_pdf_path}")
    execute_and_wait(
        ["pdfcrop"] + 2 * [str(result_pdf_path)], get_autogen_path(diagram)
    )


def convert_composite(diagram: Diagram):
    result_pdf_path = get_result_pdf_path(diagram)
    result_png_path = get_result_png_path(diagram)

    info(f"Converting {result_pdf_path} to {result_png_path}")
    execute_and_wait(
        [
            "convert",
            "-rotate",
            "90",
            "-density",
            "600",
            "-alpha",
            "off",
            str(result_pdf_path),
            str(result_png_path),
        ],
        get_autogen_path(diagram),
    )


# Path utils


def get_autogen_path(diagram: Diagram) -> Path:
    return diagram.path / "Autogen"


def get_gnuplot_file_path(diagram: Diagram) -> Path:
    return get_autogen_path(diagram) / "plot.plt"


def get_diagram_fm_path(diagram: Diagram) -> Path:
    return diagram.path / "result_fm"


def get_frame_fm_path(diagram: Diagram) -> Path:
    return get_autogen_path(diagram) / "result_fm"


def get_result_eps_path(diagram: Diagram) -> Path:
    return get_autogen_path(diagram) / "result_fm.eps"


def get_result_pdf_path(diagram: Diagram) -> Path:
    return get_autogen_path(diagram) / "result.pdf"


def get_result_png_path(diagram: diagram) -> Path:
    return get_autogen_path(diagram) / "result.png"


def get_simple_result_png_path(diagram: diagram) -> Path:
    return get_autogen_path(diagram) / "result-simple.png"
