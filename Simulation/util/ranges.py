#!/usr/bin/env python

from typing import List

from configuration.models import Parameters
from configuration.diagrams import ParameterRange

def generate_parameters_for_animation(animation: ParameterRange) -> List[Parameters]:
    parameterss = []
    for i in range(animation.resolution + 1):
        parameters = {}

        for ps in animation.parameter_specs:
            val = ps.start + i * (ps.stop - ps.start) / animation.resolution
            parameters[ps.name] = val
        
        parameterss.append(parameters)

    return parameterss
