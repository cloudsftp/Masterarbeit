#!/usr/bin/env python

from configuration.models import Model
from configuration.diagrams import Diagram
from execution.frame import Frame

def generate_ant_config_file(frame: Frame):
    pass

def generate_ant_config_files(diagram: Diagram):
    if not diagram.animation:
        frame = Frame(diagram, 0)
