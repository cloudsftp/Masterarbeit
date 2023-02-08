#1/usr/bin/env python

from __future__ import annotations

from execution import frame
from util.file import is_outdated
from util.output import info
from util.exceptions import CustomException
from configuration.diagrams import ParameterRangeType, DiagramType

def generate_ant_config_file(frame: frame.Frame):
    if not is_outdated(frame.config_file_path, frame.diagram.config_file_path, frame.diagram.model.config_file_path):
        info(f'Skipping generation of {frame.config_file_path}')
        return
    
    info(f'Generating {frame.config_file_path}')
    
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
    reset_initial = 'false'
    if (frame.diagram.reset_orbit and not frame.diagram.reset_orbit) \
        or frame.diagram.type == DiagramType.PERIOD_REGIONS:
        reset_initial = 'true'

    return f'''    state_space_dimension = 1,
    initial_state = ({frame.diagram.initial}),
    reset_initial_states_from_orbit = {reset_initial},
    number_of_iterations = {frame.diagram.num_iterations}
}},
'''

# Scan

def config_scan_start(frame: frame.Frame) -> str:
    res = f'''scan = {{
    type = nested_items,
    mode = '''
    
    if frame.scan and len(frame.scan) > 0:
        res += f'{len(frame.scan)},\n'

    else:
        res += '0\n'

    return res

def config_scan_items(frame: frame.Frame) -> str:
    res = ''

    if frame.scan and len(frame.scan) > 0:
        item_cnt = 0
        for parameter_range in frame.scan:
            if parameter_range.type == ParameterRangeType.LINEAR:
                if len(parameter_range.parameter_specs) == 1:
                    res += f'''    item[{item_cnt}] = {{
        type = "real_linear",
        object = "{parameter_range.parameter_specs[0].name}",
        points = {parameter_range.resolution},
        min = {parameter_range.parameter_specs[0].start},
        max = {parameter_range.parameter_specs[0].stop}
    }},
'''
                else:
                    res += f'''    item[{item_cnt}] = {{
        type = "real_linear_2d",
        points = {parameter_range.resolution},
        first_object = "{parameter_range.parameter_specs[0].name}",
        first_min = {parameter_range.parameter_specs[0].start},
        first_max = {parameter_range.parameter_specs[0].stop},
        second_object = "{parameter_range.parameter_specs[1].name}",
        second_min = {parameter_range.parameter_specs[1].start},
        second_max = {parameter_range.parameter_specs[1].stop}
    }},
'''
            
            else:
                raise CustomException('Parameter ranges besides linear not yet implemented!')

            item_cnt += 1
        
        res = res[:-2]
        res += '\n'

    res += '},\n'
    
    return res

# Investigation methods

def config_inverstigation_methods(frame: frame.Frame) -> str:
    period = 'false'
    cobweb = 'false'
    cyclic_bif_set = 'false'
    regions = 'false'
    
    match frame.diagram.type:
        case DiagramType.PERIOD:
            period = 'true'
        case DiagramType.COBWEB:
            cobweb = 'true'
        case DiagramType.PERIOD_REGIONS:
            regions = 'true'
        case DiagramType.ANALYSIS:
            period = 'true'
            cyclic_bif_set = 'true'
        case _:
            raise CustomException(f'AnT configuration for type {frame.diagram.type} not yet supported!')

    
    return f'''investigation_methods = {{
    general_trajectory_evaluations = {{
    }},
    period_analysis = {{
        is_active = true,
        max_period = {frame.diagram.max_periods},
        compare_precision = 1e-09,
        period = {period},
        period_file = "period.tna",
        cyclic_asymptotic_set = {cyclic_bif_set},
        cyclic_bif_dia_file = "bif_cyclic.tna",
        acyclic_last_states = false,
        acyclic_bif_dia_file = "bif_acyclic.tna",
        cyclic_graphical_iteration = {cobweb},
        cyclic_graph_iter_file = "cyclic_cobweb.tna",
        acyclic_graphical_iteration = false,
        acyclic_graph_iter_file = "acyclic_cobweb.tna",
        using_last_points = 1528,
        period_selections = false,
        periods_to_select = (),
        period_selection_file = "period_selection",
        period_selection_file_extension = "tna"
    }},
    regions_analysis = {{
        is_active = {regions},
        period_regions_file = "regions_period.tna",
        period_file = "periods_ij.tmp"
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
