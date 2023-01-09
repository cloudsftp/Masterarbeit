#!/usr/bin/env python

from typing import Dict
import re

parameter_reg = re.compile(r"\s*parameter\[.+\]")
block_end_reg = re.compile(r"\s*}")
value_reg = re.compile(r"\s*value\s*=\s*([^,]+)")
name_reg = re.compile(r"\s*name\s*=\s*\"([^\"]+)\"")

def load_parameters(diagram_dir: str) -> (Dict[str, float], Dict[str, float]):
    with open(f"{diagram_dir}/config.ant") as file:
        parsing = False

        parameter_vals = {}
        parameter_lines = {}
        
        name = None
        value = None
        val_line_num = None

        line_num = 0
        for line in file:
            line_num += 1

            if not parsing:
                if parameter_reg.match(line):
                    parsing = True

                continue

            if block_end_reg.match(line):
                if name and value and val_line_num:
                    parameter_vals[name] = value
                    parameter_lines[name] = val_line_num
                    
                    name = None
                    value = None

                parsing = False
                continue
            
            value_match = value_reg.match(line)
            if value_match:
                value = float(value_match.group(1))
                val_line_num = line_num
                
            name_match = name_reg.match(line)
            if name_match:
                name = name_match.group(1)

        return parameter_vals, parameter_lines

