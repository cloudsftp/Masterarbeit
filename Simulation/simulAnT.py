#!/usr/bin/env python

import argparse
import re
import os

def find_fullpath(name: str, root: str = None) -> str:
    if not root:
        root = os.curdir

    pattern: re.Pattern = re.compile(fr"^.*{name}$")

    for candidate, _, _ in os.walk(root):
        match: re.Match = re.match(pattern, candidate)
        if match:
            return os.path.abspath(candidate)

    raise Exception(f"Full path of {name} not found in {root}")



def main(model_name: str, diagram_name: str):
    model_path: str = find_fullpath(model_name)
    diagram_path: str = find_fullpath(diagram_name, root=model_path)
    
    print(model_path, diagram_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("-m", "--model", type=str, required=True)
    parser.add_argument("-d", "--diagram", type=str, required=True)

    arguments = parser.parse_args()
    
    main(arguments.model, arguments.diagram)
