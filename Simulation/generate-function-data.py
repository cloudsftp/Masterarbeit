#!/usr/bin/env python

import importlib.util
import sys
from Parameter.parser import load_parameters
from math import pi
import argparse


def generate_function_data(
    model_dir: str, diagram_name: str,
    start: float = 0, end: float = 2 * pi, steps: int = 1000,
) -> None:
    parameters, _ = load_parameters(f"{model_dir}/{diagram_name}")
    
    spec = importlib.util.spec_from_file_location("function_module", f"{model_dir}/function.py")
    function_module = importlib.util.module_from_spec(spec)
    sys.modules["function_module"] = function_module
    spec.loader.exec_module(function_module)

    with open(f"{model_dir}/{diagram_name}/function.dat", "w") as file:
        x: float = start
        d: float = (end - start) / steps

        for _ in  range(steps):
            file.write(f"{x} {function_module.function(x, parameters)}\n")
            x += d

if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('-m', '--model-dir', type=str, required=True)
    parser.add_argument('-d', '--diagram-name', type=str, required=True)
    
    args = parser.parse_args()
    
    generate_function_data(args.model_dir, args.diagram_name)

