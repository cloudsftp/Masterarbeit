#!/usr/bin/env python

from configuration.diagrams import Diagram
from execution.frame import Frame

def generate_diagram(diagram: Diagram):
    if not diagram.animation:
        frame = Frame(diagram, 0)
        frame.run()

