#!/usr/bin/env python

from typing import Optional
from pathlib import Path
import argparse

from util.file import find_fullpath
from configuration.models import Model
from configuration.diagrams import Diagram


def main(model_name: str, diagram_name: str):
    model_path: Path = find_fullpath(model_name)
    diagram_path: Path = find_fullpath(diagram_name, root=model_path)
    
    model = Model(model_path)
    model.compile()
    
    diagram = Diagram(diagram_path, model)
    print(diagram.scan[0].parameter_specs[0].name)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("-m", "--model", type=str, required=True)
    parser.add_argument("-d", "--diagram", type=str, required=True)

    arguments = parser.parse_args()
    
    main(arguments.model, arguments.diagram)
