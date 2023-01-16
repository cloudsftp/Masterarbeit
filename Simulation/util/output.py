#!/usr/bin/env python

GREEN = '\033[0;32m'
RED = '\033[0;31m'
NONE = '\033[0m'

def info(msg: str):
    print(f'[{GREEN}INFO{NONE}] {msg}')

def error(msg: str):
    print(f'[{RED}ERROR{NONE}] {msg}')
