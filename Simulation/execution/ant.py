#!/usr/bin/env python

from __future__ import annotations
from enum import Enum
from subprocess import Popen
import socket

from execution import frame
from util.output import info

class ExecutionType(Enum):
    STANDALONE = 0,
    SERVER = 1,
    CLIENT = 2,

server_ip = '0.0.0.0'
client_ip = 'localhost'

port = 5555

num_cores = {
    'workstation': 12,
    'openSuseBook': 6,
}

def execute_simulation(frame: frame.Frame):
    if frame.diagram.scan:
        execute_simulation_server_mode(frame)
    
    else:
        execute_simulation_standalone_mode(frame)

def execute_simulation_server_mode(frame: frame.Frame):
    num_cores = get_num_cores()

    info('Starting server')
    server = start_ant(ExecutionType.SERVER)

    for i in range(num_cores):
        info(f'Starting client #{i}')
        
    # TODO: wait for completion

def get_num_cores() -> int:
    host = socket.gethostname()
    res = num_cores.get(host)

    if not res:
        raise Exception(f'No number of cores configured for host {host}')

    return res

def start_ant(exec_type: ExecutionType) -> Popen:
    pass
