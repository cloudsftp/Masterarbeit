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
        # TODO check is dict
        
        if 'name' not in config:
            raise Exception('"name" not in diagram  parameter range specification')

        name = config['name']
        if not isinstance(name, str):
            raise Exception('"name" in diagram parameter range specification should be str')

        self.name = name
        
        if 'start' not in config:
            raise Exception('"start" not in diagram  parameter range specification')        
            
        start = config['start']
        if not isinstance(start, float):
            raise Exception('"start" in diagram parameter range specification should be float')

        self.start = start
 
        if 'stop' not in config:
            raise Exception('"stop" not in diagram  parameter range specification')        
            
        stop = config['stop']
        if not isinstance(start, float):
            raise Exception('"stop" in diagram parameter range specification should be float')

        self.stop = stop

class ParameterRange:
    type: ParameterRangeType
    resolution: int

    parameter_specs: List[ParameterRangeSpecification]
    
    def __init__(self, config: Union[Dict[str, Any], Any], model: Model):
        # TODO check is dict

        if 'type' not in config:
            raise Exception('"type" not in diagram parameter range configuration')

        type = config['type']
        if type == 'linear':
            self.type = ParameterRangeType.LINEAR
        
        if 'resolution' not in config:
            raise Exception('"resolution" not in diagram parameter range configuration')

        resolution = config['resolution']
        if not isinstance(resolution, int):
            raise Exception('"resolution" in diagram parameter range configuraion should be int')
        
        self.resolution = resolution
        
        if 'parameters' not in config:
            raise Exception('"parameters" not in diagram parameter range configuration')

        parameters = config['parameters']
        if not isinstance(parameters, list):
            raise Exception('"parameters" in diagram parameter range configuration should be list')

        self.parameter_specs = []
        for parameter in parameters:
            self.parameter_specs.append(ParameterRangeSpecification(parameter, model))


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
            
            if 'type' not in config:
                raise Exception(f'"type" missing in {config_file_path}')

            type = config['type']
            if type == 'period':
                self.type = DiagramType.PERIOD
            elif type == 'period regions':
                self.type = DiagramType.PERIOD_REGIONS
            elif type == 'cobweb':
                self.type = DiagramType.COBWEB

            if 'scan' not in config or not config['scan']:
                self.scan = None
            else:
                # TODO: check is list

                self.scan = []
                for parameter_range in config['scan']:
                    self.scan.append(ParameterRange(parameter_range, model))
            
            if 'animation' not in config or not config['animation']:
                self.animation = None
            else:
                self.animation = ParameterRange(config['animation'], model)
