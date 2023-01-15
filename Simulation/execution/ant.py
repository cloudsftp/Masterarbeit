#!/usr/bin/env python

from __future__ import annotations
from enum import Enum
import subprocess
import socket
import time

from execution import frame
from util.output import info
from util.execute import ant

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
    server = start_ant(frame, ExecutionType.SERVER)

    for i in range(num_cores):
        info(f'Starting client #{i}')
        
    # TODO: wait for completion

def get_num_cores() -> int:
    host = socket.gethostname()
    res = num_cores.get(host)

    if not res:
        raise Exception(f'No number of cores configured for host {host}')

    return res

def start_ant(frame: frame.Frame, exec_type: ExecutionType) -> subprocess.Popen:
    if exec_type == ExecutionType.SERVER:
        while True:
            server = create_ant_process(frame, exec_type)
            
            
            while True:
                output = server.stdout.readline()
                err = server.stderr.readline()
                if err:
                    print(err.decode(), end='')
                else:
                    print('.', end='')
                
                time.sleep(0.1)

    
    else:
        raise Exception('Only starting server supported')

def create_ant_process(frame: frame.Frame, exec_type: ExecutionType) -> subpro.Popen:
    arguments = [
        ant,
        f'{frame.diagram.model.library_file_path}',
        '-i', f'{frame.config_file_path}',
    ]
    
    if exec_type == ExecutionType.SERVER:
        arguments.extend([
            '-m', 'server',
            '-s', f'"{server_ip}"',
            '-p', f'"{port}"',
        ])
    elif exec_type == ExecutionType.CLIENT:
        arguments.extend([
            '-m', 'client',
            '-s', f'"{client_ip}"',
            '-p', f'"{port}"',
            '-t', '20',
        ])

    return subprocess.Popen(
        arguments,
        cwd = frame.path,
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )
