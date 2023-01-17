#!/usr/bin/env python

from typing import Optional, List
from pathlib import Path
import subprocess
from util.exceptions import CustomException

def execute_and_wait(args: List[str], cwd: Optional[Path] = None):
    if not cwd:
        cwd = Path.cwd()

    process = subprocess.run(
        args,
        cwd = cwd,
        stdout = subprocess.PIPE,
        stderr = subprocess.STDOUT,
    )
    
    if process.returncode > 0:
        if process.stdout:
            print()
            print(process.stdout.decode())

        raise CustomException(f'Problem while executing {args[0]}')
