#!/usr/bin/env python

from __future__ import annotations
from enum import Enum
import subprocess
import socket
import time
import re
import threading

from configuration.diagrams import DiagramType
from execution import frame
from util.output import info
from util.paths import ant, ant_log_file, ant_client_log_file
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
    data_file_paths = get_data_file_paths(frame)
    if not any([
            is_outdated(data_file_path, frame.config_file_path, frame.diagram.model.model_source_file_path)
            for data_file_path in data_file_paths
        ]) \
        or frame.diagram.options.skip_computation:
        
        info(f'Skipping simulation and generation of {data_file_paths}')
        return

    if frame.scan and not frame.diagram.options.num_cores == 1:
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
        client = start_ant(frame, ExecutionType.CLIENT)
        write_client_log_async(client, i)
 
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
        ])
        
        if len(frame.diagram.scan) > 1:
            arguments.extend(['-n', f'{get_num_points(frame)}'])
        else:
            arguments.extend(['-t', '20'])


    return subprocess.Popen(
        arguments,
        cwd = frame.path,
        stdout = subprocess.PIPE,
        stderr = subprocess.STDOUT,
    )

def get_num_points(frame: frame.Frame) -> int:
    row_len = [s.resolution for s in frame.scan]

    if len(frame.scan) == 2:
        return row_len[1]

    else:
        raise CustomException(f'get_num_points not implemented for {len(frame.scan)} scans')


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
                logfile.flush()

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
            if exit_code is not None:
                print('\n')
                info('Simulation done\n')
                break

def write_client_log_async(process: Popen, id: int):
    threading.Thread(None, write_client_log, args=(process, id)).start()

def write_client_log(process: Popen, id: int):
    with open(ant_client_log_file(id), 'w') as logfile:
        while True:
            line = process.stdout.readline().decode()
            if line == '' and process.poll() is not None:
                break
            logfile.write(line)
            logfile.flush()
        
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

def get_data_file_paths(frame: execution.frame.Frame) -> List[Path]:
    if frame.diagram.type == DiagramType.PERIOD:
        return [get_period_path(frame)]
    elif frame.diagram.type == DiagramType.COBWEB:
        return [get_cyclic_cobweb_path(frame)]
    elif frame.diagram.type == DiagramType.PERIOD_REGIONS:
        return [get_regions_path(frame)]
    elif frame.diagram.type == DiagramType.ANALYSIS:
        return [get_period_path(frame), get_cyclic_bif_path(frame)]
    elif frame.diagram.type == DiagramType.BIFURCATION:
        return [get_cyclic_bif_path(frame)]
    else:
        raise CustomException(f'Executing simulation for type {frame.diagram.type} not yet supported!')

def get_period_path(frame: execution.frame.Frame) -> Path:
    return frame.path / 'period.tna'

def get_cyclic_cobweb_path(frame: execution.frame.Frame) -> Path:
    return frame.path / 'cyclic_cobweb.tna'

def get_cyclic_bif_path(frame:execution.frame.Frame) -> Path:
    return frame.path / 'bif_cyclic.tna'

def get_regions_path(frame: exeution.frame.Frame) -> Path:
    return frame.path / 'regions_period.tna'
