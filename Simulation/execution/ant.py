#!/usr/bin/env python

from __future__ import annotations
from enum import Enum
import subprocess
import socket
import time
import re

from configuration.diagrams import DiagramType
from execution import frame
from util.output import info
from util.paths import ant, ant_log_file
from util.file import is_outdated
from util.exceptions import CustomException

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
exit_pattern = re.compile(r'Bye!')

def execute_simulation(frame: frame.Frame):
    data_file_path = get_data_file_path(frame)
    if not is_outdated(data_file_path, frame.config_file_path, frame.diagram.model.model_source_file_path) \
        or frame.diagram.options.skip_computation:
        
        info(f'Skipping simulation and generation of {data_file_path}')
        return

    if frame.diagram.scan and not frame.diagram.options.num_cores == 1:
        execute_simulation_server_mode(frame)
    
    else:
        execute_simulation_standalone_mode(frame)

# Executing

def execute_simulation_server_mode(frame: frame.Frame):
    num_cores = get_num_cores(frame)

    info('Starting server')
    server = start_ant(frame, ExecutionType.SERVER)

    for i in range(num_cores):
        info(f'Starting client #{i}')
        start_ant(frame, ExecutionType.CLIENT)
        
    wait_for_simulation(server)

def get_num_cores(frame: frame.Frame) -> int:
    if frame.diagram.options.num_cores:
        return frame.diagram.options.num_cores

    host = socket.gethostname()
    res = num_cores.get(host)

    if not res:
        raise CustomException(f'No number of cores configured for host {host}, please specify with option --num-cores')

    return res

def execute_simulation_standalone_mode(frame: frame.Frame):
    info('Executing simulation in standalone mode')
    process = start_ant(frame,ExecutionType.STANDALONE)
    wait_for_simulation(process)

# Starting the processes

def start_ant(frame: frame.Frame, exec_type: ExecutionType) -> subprocess.Popen:
    if exec_type == ExecutionType.SERVER:
        while True:
            server = create_ant_process(frame, exec_type)
            print('.', end='', flush=True)

            with ant_log_file.open('w') as logfile:
                log = ''
                while True:
                    output = server.stdout.readline()
                    
                    if output:
                        output_str = output.decode()
                        logfile.write(output_str)
                        log += output_str

                        if successful_server_start_pattern.match(output_str):
                            print('success\n')
                            return server

                        elif network_problem_server_start_pattern.match(output_str):
                            break

                        elif exit_pattern.match(output_str):
                            print()
                            print(log)
                            
                            raise CustomException(f'Server terminated unexpectedly')

                    time.sleep(0.01)
            
            time.sleep(1)
    
    else:
        return create_ant_process(frame, exec_type)

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
        stderr = subprocess.STDOUT,
    )

# Handling running simulations

def wait_for_simulation(process: Popen):
    start_time = time.time()

    print()
    with ant_log_file.open('a') as logfile:
        while True:
            output = process.stdout.readline()

            if output:
                output_str = output.decode()
                logfile.write(output_str)

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
                print('\n')
                info('Simulation done\n')
                break
        
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

# Path utils

def get_data_file_path(frame: execution.frame.Frame) -> Path:
    if frame.diagram.type == DiagramType.PERIOD:
        return frame.path / 'period.tna'
    elif frame.diagram.type == DiagramType.COBWEB:
        return frame.path / 'cyclic_cobweb.tna'
    else:
        raise CustomException(f'Executing simulation for type {frame.diagram.type} not yet supported!')
