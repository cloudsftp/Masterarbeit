#!/usr/bin/env python

from typing import Optional
from pathlib import Path
import argparse

from util.file import find_fullpath
from util.output import error
from util.exceptions import CustomException
from configuration.models import Model
from configuration.diagrams import Diagram
from configuration.options import Options
from execution.execute import generate_diagram

def main(model_name: str, diagram_name: str, options: Options):
    model_path: Path = find_fullpath(model_name)
    diagram_path: Path = find_fullpath(diagram_name, root=model_path)
    
    model = Model(model_path)
    model.compile()
    
    diagram = Diagram(diagram_path, model, options)
    generate_diagram(diagram)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("-m", "--model", type=str, required=True)
    parser.add_argument("-d", "--diagram", type=str, required=True)
    
    parser.add_argument('-n', '--num-cores', type=int, default=None)
    parser.add_argument('-s', '--simple-figure', action=argparse.BooleanOptionalAction)

    arguments = parser.parse_args()
    
    options = Options(arguments.simple_figure, arguments.num_cores)
    
    try:
        main(arguments.model, arguments.diagram, options)
    
    except CustomException as e:
        error(e)
