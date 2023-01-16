#!/usr/bin/env python

from dataclasses import dataclass
from typing import Optional

@dataclass
class Options:
    simple_figure: bool = False
    skip_computation: bool = False
    num_cores: Optional[int] = None
