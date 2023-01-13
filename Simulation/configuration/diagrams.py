#!/usr/bin/env python

from typing import Optional, List, Dict, Any, Union
from pathlib import Path
from enum import Enum
import json

from configuration.models import Model, Parameters, join_parameters

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

    parameters: Parameters                  # parameters differing from model parameters
    scan: Optional[List[ParameterRange]]    # up to two dimensions possible (x, y)
    animation: Optional[ParameterRange]     # only one dimension possible (t)
    
    def __init__(self, diagram_path: Path, model: Model):
        self.model = model

        self.path = diagram_path
        config_file_path = diagram_path / 'config.json'

        with config_file_path.open() as config_file:
            config: Dict[str, Any] = json.load(config_file)
 
            load_diagram_from_dict(self, config, model)
        
        self.parameters = join_parameters(model.parameters, self.parameters)










def load_parameter_range_specification_from_dict(
    obj: ParameterRangeSpecification,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    if not isinstance(config, dict):
        raise Exception('Diagram parameter range specification should be dict')
    
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
    obj: ParameterRange,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    if not isinstance(config, dict):
        raise Exception('Diagram parameter range should be dict')
    
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
    if not isinstance(config, dict):
        raise Exception('Diagram configuration should be dict')
           
    if 'type' not in config:
        raise Exception('"type" missing in diagram configuration')

    type = config['type']
    if type == 'period':
        obj.type = DiagramType.PERIOD
    elif type == 'period regions':
        obj.type = DiagramType.PERIOD_REGIONS
    elif type == 'cobweb':
        obj.type = DiagramType.COBWEB

    if 'parameters' not in config or not config['parameters']:
        obj.parameters = {}
    else:
        parameters = config['parameters']
        if not isinstance(parameters, dict):
            raise Exception('"parameters" in diagram configuration should be dict')
        
        for name in parameters:
            if not (isinstance(parameters[name], float) or isinstance(parameters[name], int)):
                raise Exception(f'Parameter "{name}" in diagram configuration file should be float or int')
        
        obj.parameters = parameters

    if 'scan' not in config or not config['scan']:
        obj.scan = None
    else:
        scan = config['scan']
        if not isinstance(scan, list):
            raise Exception('"scan" in diagram configuration should be list')

        obj.scan = []
        for parameter_range in scan:
            obj.scan.append(ParameterRange(parameter_range, model))

    if 'animation' not in config or not config['animation']:
        obj.animation = None
    else:
        obj.animation = ParameterRange(config['animation'], model)
