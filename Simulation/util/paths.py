#!/usr/bin/env python

from pathlib import Path

ant_path = Path('AnT').absolute()
ant_library_path = ant_path / 'lib64'
ant_executable_path = ant_path / 'bin'

build_system = ant_executable_path / 'build-AnT-system.sh'
ant = ant_executable_path / 'AnT'

ant_log_path = Path('Logs').absolute()
ant_log_file = ant_log_path / 'server.log'

# Frame specific


