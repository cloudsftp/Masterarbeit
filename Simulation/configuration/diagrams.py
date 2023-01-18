#!/usr/bin/env python

from typing import Optional, List, Dict, Any, Union
from pathlib import Path
from enum import Enum
import json

from util.exceptions import CustomException
from configuration.models import Model, Parameters, join_parameters
from configuration.options import Options

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
    config_file_path: Path
    type: DiagramType

    parameters: Parameters                  # parameters differing from model parameters
    scan: Optional[List[ParameterRange]]    # up to two dimensions possible (x, y)
    animation: Optional[ParameterRange]     # only one dimension possible (t)
    
    max_periods: int = 128
    num_iterations: int = 1000
    reset_orbit: bool = True

    L: Optional[float] = None
    R: Optional[float] = None
    D: Optional[float] = None
    U: Optional[float] = None
    
    def __init__(self, diagram_path: Path, model: Model, options: Options):
        self.model = model
        self.options = options

        self.path = diagram_path
        self.config_file_path = diagram_path / 'config.json'

        with self.config_file_path.open() as config_file:
            config: Dict[str, Any] = json.load(config_file)
 
            load_diagram_from_dict(self, config, model)
        
        self.parameters = join_parameters(model.parameters, self.parameters)










def load_parameter_range_specification_from_dict(
    obj: ParameterRangeSpecification,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    if not isinstance(config, dict):
        raise CustomException('Diagram parameter range specification should be dict')
    
    if 'name' not in config:
        raise CustomException('"name" not in diagram  parameter range specification')        

    name = config['name']
    if not isinstance(name, str):
        raise CustomException('"name" in diagram parameter range specification should be str')

    obj.name = name
    
    if 'start' not in config:
        raise CustomException('"start" not in diagram  parameter range specification')        
        
    start = config['start']
    if not (isinstance(start, float) or isinstance(start, int)):
        raise CustomException('"start" in diagram parameter range specification should be float or int')

    obj.start = start

    if 'stop' not in config:
        raise CustomException('"stop" not in diagram  parameter range specification')        
        
    stop = config['stop']
    if not (isinstance(stop, float) or isinstance(stop, int)):
        raise CustomException('"stop" in diagram parameter range specification should be float or int')

    obj.stop = stop

def load_parameter_range_from_dict(
    obj: ParameterRange,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    if not isinstance(config, dict):
        raise CustomException('Diagram parameter range should be dict')
    
    if 'type' not in config:
        raise CustomException('"type" not in diagram parameter range configuration')

    type = config['type']
    if type == 'linear':
        obj.type = ParameterRangeType.LINEAR
    
    if 'resolution' not in config:
        raise CustomException('"resolution" not in diagram parameter range configuration')

    resolution = config['resolution']
    if not isinstance(resolution, int):
        raise CustomException('"resolution" in diagram parameter range configuraion should be int')
    
    obj.resolution = resolution
    
    if 'parameters' not in config:
        raise CustomException('"parameters" not in diagram parameter range configuration')

    parameters = config['parameters']
    if not isinstance(parameters, list):
        raise CustomException('"parameters" in diagram parameter range configuration should be list')

    obj.parameter_specs = []
    for parameter in parameters:
        obj.parameter_specs.append(ParameterRangeSpecification(parameter, model))

def load_diagram_from_dict(
    obj: Diagram,
    config: Union[Dict[str, Any], Any],
    model: Model,
):
    if not isinstance(config, dict):
        raise CustomException('Diagram configuration should be dict')
           
    if 'type' not in config:
        raise CustomException('"type" missing in diagram configuration')

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
            raise CustomException('"parameters" in diagram configuration should be dict')
        
        for name in parameters:
            if not (isinstance(parameters[name], float) or isinstance(parameters[name], int)):
                raise CustomException(f'Parameter "{name}" in diagram configuration file should be float or int')
        
        obj.parameters = parameters

    if 'scan' not in config or not config['scan']:
        obj.scan = None
    else:
        scan = config['scan']
        if not isinstance(scan, list):
            raise CustomException('"scan" in diagram configuration should be list')

        obj.scan = []
        for parameter_range in scan:
            obj.scan.append(ParameterRange(parameter_range, model))

    if 'animation' not in config or not config['animation']:
        obj.animation = None
    else:
        obj.animation = ParameterRange(config['animation'], model)
    
    if 'max_period' in config:
        obj.max_periods = config['max_period']
    
    if 'num_iterations' in config:
        obj.num_iterations = config['num_iterations']
    
    if 'reset_orbit' in config:
        obj.reset_orbit = config['reset_orbit']
    
    if 'L' in config:
        obj.L = config['L']
 
    if 'R' in config:
        obj.R = config['R']
 
    if 'D' in config:
        obj.D = config['D']
 
    if 'U' in config:
        obj.U = config['U']
