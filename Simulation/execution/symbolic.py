from pathlib import Path

from util.exceptions import CustomException

from execution.frame import Frame
from configuration.diagrams import Diagram


# Symbolic Sequences

SYMBOLS = ["A", "B", "C", "D"]


def process_simple_symbolic(frame: Frame):
    cycles = []

    with open(get_symbolic_raw_file(frame)) as raw_file:
        for line in raw_file:
            num_symbols = {symbol: 0 for symbol in SYMBOLS}

            for char in line:
                if char in SYMBOLS:
                    num_symbols[char] += 1

            cycle = ""
            for symbol in SYMBOLS:
                cycle += f"{symbol}{num_symbols[symbol]} "
            cycle = cycle[:-1]

            cycles.append(cycle)

    cycles = {cycle for cycle in cycles}  # filter duplicated

    for cycle in cycles:
        print(cycle)

    pass


def process_symbolic(diagram: Diagram):
    if diagram.animation != None:
        print("Symbolic Sequence not yet supported for animation")
        return


# Paths


def get_symbolic_raw_file(frame: Frame) -> Path:
    return frame.path / "periodic_symbolic_sequence.tna"


def get_symbolic_target_file(frame: Frame) -> Path:
    return frame.diagram / "symbolic.txt"
