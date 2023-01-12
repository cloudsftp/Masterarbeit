#!/usr/bin/env python

from typing import Optional, Dict, Any
from pathlib import Path
from enum import Enum
import json

class DiagramType(Enum):
    PERIOD = 0,
    PERIOD_REGIONS = 1,
    COBWEB = 2

class ParameterRange:
    pass

class DiagramScan:
    pass

class Diagram(object):
    path: Path
    type: DiagramType

    scan: Optional[DiagramScan]
    animation: Optional[ParameterRange]
    
    def __init__(self, diagram_path: Path):
        self.path = diagram_path
        config_file_path = diagram_path / 'config.json'

        with config_file_path.open() as config_file:
            config: Dict[str, Any] = json.load(config_file)
            
            if not 'type' in config:
                raise Exception(f'"type" missing in {config_file_path}')

            type: str = config['type']
            if type == 'period':
                self.type = DiagramType.PERIOD
            elif type == 'period regions':
                self.type = DiagramType.PERIOD_REGIONS
            elif type == 'cobweb':
                self.type = DiagramType.COBWEB
