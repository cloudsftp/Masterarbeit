#!/usr/bin/env python

from __future__ import annotations
from enum import Enum
import subprocess
import socket
import time
import re

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

successful_server_start_pattern = re.compile(r'.*accepting connections now')
network_problem_server_start_pattern = re.compile(r'.*Could not bind to address')
progress_indicator_pattern = re.compile(r'.*progress\s([^%]+)%')

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
        start_ant(frame, ExecutionType.CLIENT)
        
    wait_for_simulation(server)

def get_num_cores() -> int:
    host = socket.gethostname()
    res = num_cores.get(host)

    if not res:
        raise Exception(f'No number of cores configured for host {host}')

    return res

# Starting the processes

def start_ant(frame: frame.Frame, exec_type: ExecutionType) -> subprocess.Popen:
    if exec_type == ExecutionType.SERVER:
        while True:
            server = create_ant_process(frame, exec_type)
            print('.', end='', flush=True)

            while True:
                output = server.stdout.readline()
                
                if output:
                    output_str = output.decode()

                    if successful_server_start_pattern.match(output_str):
                        print('success')
                        return server

                    elif network_problem_server_start_pattern.match(output_str):
                        break

                if server.poll():
                    if server.stderr:
                        print(server.stderr.decode())

                    raise Exception('Server terminated unexpectedly. Stderr is displayed above')

                time.sleep(0.01)
            
            time.sleep(1)
    
    elif exec_type == ExecutionType.CLIENT:
        return create_ant_process(frame, ExecutionType.CLIENT)

    else:
        raise Exception(f'Execution type {exec_type} not supported')

def create_ant_process(frame: frame.Frame, exec_type: ExecutionType) -> subpro.Popen:
    arguments = [
        ant,
        f'{frame.diagram.model.library_file_path}',
        '-i', f'{frame.config_file_path}',
    ]
    
    if exec_type == ExecutionType.SERVER:
        arguments.extend([
            '-m', 'server',
            '-s', f'{server_ip}',
            '-p', f'{port}',
        ])
    elif exec_type == ExecutionType.CLIENT:
        arguments.extend([
            '-m', 'client',
            '-s', f'{client_ip}',
            '-p', f'{port}',
            '-t', '20',
        ])

    return subprocess.Popen(
        arguments,
        cwd = frame.path,
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )

# Handling running simulations

def wait_for_simulation(process: Popen):
    start_time = time.time()

    print()
    while True:
        output = process.stdout.readline()

        if output:
            output_str = output.decode()

            progress_indicator_match = progress_indicator_pattern.match(output_str)
            if progress_indicator_match:
                progress = float(progress_indicator_match.group(1))

                curr_time = time.time()
                eta = ((curr_time - start_time) / progress) * (100 - progress)
                eta_str = format_eta(eta)

                print(100 * '#', end='\r')
                print(100 * ' ', end='\r')
                print(f'Progress: {int(progress)}%, ETA: {eta_str}', end='\r', flush=True)

        exit_code = process.poll()
        if exit_code != None:
            print()
            if exit_code == 0:
                info('Simulation done')
                break
            
            elif exit_code > 0:
                if process.stderr:
                    print(process.stderr.decode())
                
                raise Exception('Server terminated unexpectedly. Stderr is displayed above')
        
def format_eta(eta: float) -> str:
    eta_int = int(eta)
    
    eta_seconds = eta_int % 60
    res = f'{eta_seconds:2d}s'
    eta_int = eta_int - eta_seconds
    
    if eta_int <= 0:
        return res
    
    eta_int = int(eta_int / 60)
    eta_minutes = eta_int % 60
    res = f'{eta_minutes:2d}m {res}'
    eta_int -= eta_minutes

    if eta_int <= 0:
        return res
    
    eta_int = int(eta_int / 60)
    res = f'{eta_int:4d}h {res}'

    return res
