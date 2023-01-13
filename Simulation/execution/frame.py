#!/usr/bin/env python

from typing import List, Dict

from configuration.models import Parameters

class Frame:
    id: int
    path: str

    parameters: Parameters
