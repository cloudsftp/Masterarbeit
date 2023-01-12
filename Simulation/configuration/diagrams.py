#!/usr/bin/env python

from typing import Optional, List, Dict, Any, Union
from pathlib import Path
from enum import Enum
import json

from configuration.models import Model

class DiagramType(Enum):
    PERIOD = 0,
    PERIOD_REGIONS = 1,
    COBWEB = 2,

class ParameterRangeType(Enum):
    LINEAR = 0,

class ParameterRangeSpecification:
    name: str
    start: float
    stop: float

    def __init__(self, config: Union[Dict[str, Any], Any], model: Model):
        load_parameter_range_specification_from_dict(self, config, model)

class ParameterRange:
    type: ParameterRangeType
    resolution: int

    parameter_specs: List[ParameterRangeSpecification]
    
    def __init__(self, config: Union[Dict[str, Any], Any], model: Model):
        load_parameter_range_from_dict(self, config, model)


class Diagram(object):
    model: Model

    path: Path
    type: DiagramType

    scan: Optional[List[ParameterRange]]    # up to two dimensions possible (x, y)
    animation: Optional[ParameterRange]     # only one dimension possible (t)
    
    def __init__(self, diagram_path: Path, model: Model):
        self.model = Model

        self.path = diagram_path
        config_file_path = diagram_path / 'config.json'

        with config_file_path.open() as config_file:
            config: Dict[str, Any] = json.load(config_file)
 
            load_diagram_from_dict(self, config, model)










def load_parameter_range_specification_from_dict(
    obj: ParameterRangeSpecification,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    # TODO check is dict
    
    if 'name' not in config:
        raise Exception('"name" not in diagram  parameter range specification')        

    name = config['name']
    if not isinstance(name, str):
        raise Exception('"name" in diagram parameter range specification should be str')

    obj.name = name
    
    if 'start' not in config:
        raise Exception('"start" not in diagram  parameter range specification')        
        
    start = config['start']
    if not isinstance(start, float):
        raise Exception('"start" in diagram parameter range specification should be float')

    obj.start = start

    if 'stop' not in config:
        raise Exception('"stop" not in diagram  parameter range specification')        
        
    stop = config['stop']
    if not isinstance(start, float):
        raise Exception('"stop" in diagram parameter range specification should be float')

    obj.stop = stop

def load_parameter_range_from_dict(
    obj: ParameterRangeSpecification,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    # TODO check is dict

    if 'type' not in config:
        raise Exception('"type" not in diagram parameter range configuration')

    type = config['type']
    if type == 'linear':
        obj.type = ParameterRangeType.LINEAR
    
    if 'resolution' not in config:
        raise Exception('"resolution" not in diagram parameter range configuration')

    resolution = config['resolution']
    if not isinstance(resolution, int):
        raise Exception('"resolution" in diagram parameter range configuraion should be int')
    
    obj.resolution = resolution
    
    if 'parameters' not in config:
        raise Exception('"parameters" not in diagram parameter range configuration')

    parameters = config['parameters']
    if not isinstance(parameters, list):
        raise Exception('"parameters" in diagram parameter range configuration should be list')

    obj.parameter_specs = []
    for parameter in parameters:
        obj.parameter_specs.append(ParameterRangeSpecification(parameter, model))

def load_diagram_from_dict(
    obj: Diagram,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    # TODO: check if dict
           
    if 'type' not in config:
        raise Exception(f'"type" missing in {config_file_path}')

    type = config['type']
    if type == 'period':
        obj.type = DiagramType.PERIOD
    elif type == 'period regions':
        obj.type = DiagramType.PERIOD_REGIONS
    elif type == 'cobweb':
        obj.type = DiagramType.COBWEB

    if 'scan' not in config or not config['scan']:
        obj.scan = None
    else:
        # TODO: check is list

        obj.scan = []
        for parameter_range in config['scan']:
            obj.scan.append(ParameterRange(parameter_range, model))
    
    if 'animation' not in config or not config['animation']:
        obj.animation = None
    else:
        obj.animation = ParameterRange(config['animation'], model)
