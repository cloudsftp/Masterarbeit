#1/usr/bin/env python

from __future__ import annotations

from execution import frame
from util.file import is_outdated
from util.output import info
from configuration.diagrams import ParameterRangeType

def generate_ant_config_file(frame: frame.Frame):
    if not is_outdated(frame.config_file_path, frame.diagram.config_file_path, frame.diagram.model.config_file_path):
        info(f'Skipping generation of AnT config file "{frame.config_file_path}"')
        # return
    
    with frame.config_file_path.open('w') as ant_config_file:
        ant_config_file.write(config_dynamical_system_start(frame))
        ant_config_file.write(config_dynamical_system_parameters(frame))
        ant_config_file.write(config_dynamical_system_end(frame))
        
        ant_config_file.write(config_scan_start(frame))
        ant_config_file.write(config_scan_items(frame))
        
        ant_config_file.write(config_inverstigation_methods(frame))


# Dynamical System

def config_dynamical_system_start(frame: frame.Frame) -> str:
    return f'''dynamical_system = {{
    type = map,
    name = "map",
    parameter_space_dimension = {len(frame.parameters)},
'''

def config_dynamical_system_parameters(frame: frame.Frame) -> str:
    res = '    parameters = {\n'

    cnt = 0
    for name in frame.parameters:
        res += f'''        parameter[{cnt}] = {{
            name = "{name}",
            value = {frame.parameters[name]}
        }},
'''
        cnt += 1

    res = res[:-2]
    res += '\n    },\n'
    
    return res

def config_dynamical_system_end(frame: frame.Frame) -> str:
    return f'''    state_space_dimension = 1,
    initial_state = (0.1),
    reset_initial_states_from_orbit = true,
    number_of_iterations = 1000
}},
'''

# Scan

def config_scan_start(frame: frame.Frame) -> str:
    res = f'''scan = {{
    type = nested_items,
    mode = {len(frame.diagram.scan)}'''

    if len(frame.diagram.scan) > 0:
        res += ','
    res += '\n'

    return res

def config_scan_items(frame: frame.Frame) -> str:
    res = ''

    item_cnt = 0
    for parameter_range in frame.diagram.scan:
        if parameter_range.type == ParameterRangeType.LINEAR:
            scan_type = 'real_linear'

            if len(parameter_range.parameter_specs) == 1:
                res += f'''    item[{item_cnt}] = {{
        type = {scan_type},
        object = "{parameter_range.parameter_specs[0].name},
        points = {parameter_range.resolution},
        min = {parameter_range.parameter_specs[0].start},
        min = {parameter_range.parameter_specs[0].stop}
    }},
'''
            else:
                raise Exception('2D linear diagonal scans not yet implemented!')
        
        else:
            raise Exception('Parameter ranges besides linear not yet implemented!')

        item_cnt += 1
    
    res = res[:-2]
    res += '\n},\n'
    
    return res

# Investigation methods

def config_inverstigation_methods(frame: frame.Frame) -> str:
    return f'''investigation_methods = {{
    general_trajectory_evaluations = {{
    }},
    period_analysis = {{
        is_active = true,
        max_period = 128,
        compare_precision = 1e-09,
        period = true,
        period_file = "period.tna",
        cyclic_asymptotic_set = false,
        cyclic_bif_dia_file = "bif_cyclic.tna",
        acyclic_last_states = false,
        acyclic_bif_dia_file = "bif_acyclic.tna",
        cyclic_graphical_iteration = false,
        cyclic_graph_iter_file = "cyclic_cobweb.tna",
        acyclic_graphical_iteration = false,
        acyclic_graph_iter_file = "acyclic_cobweb.tna",
        using_last_points = 1528,
        period_selections = false,
        periods_to_select = (),
        period_selection_file = "period_selection",
        period_selection_file_extension = "tna"
    }},
    band_counter = {{
    }},
    symbolic_analysis = {{
    }},
    rim_analysis = {{
    }},
    symbolic_image_analysis = {{
    }},
    lyapunov_exponents_analysis = {{
    }},
    dimensions_analysis = {{
    }},
    check_for_conditions = {{
    }}
}}
'''
