#!/usr/bin/env python

from util.exceptions import CustomException
from configuration.diagrams import Diagram
from execution.frame import Frame

def generate_diagram(diagram: Diagram):
    if not diagram.animation:
        frame = Frame(diagram, 0)
        frame.run()
    
    else:
        raise CustomException('Animations not yet implemented!')

