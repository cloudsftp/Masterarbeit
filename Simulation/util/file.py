#!/usr/bin/env python

from typing import Optional, List
from pathlib import Path

import re
import os

def walk(path: Path): 
    for p in Path(path).iterdir(): 
        if p.is_dir(): 
            yield p.resolve()
            yield from walk(p)
            continue

def find_fullpath(name: str, root: Path = None) -> Path:
    if not root:
        root = Path.cwd()

    pattern: re.Pattern = re.compile(fr"^.*{name}$")

    for candidate in walk(root):
        match: Optional[re.Match] = re.match(pattern, str(candidate))
        if match:
            return Path(candidate)

    raise Exception(f"Full path of {name} not found in {root}")

def is_outdated(target: Path, *sources: Path) -> bool:
    try:
        target_time: int = target.stat().st_mtime_ns
    except:
        return True
    
    if len(sources) < 1:
        return True
    
    source_times: List[int] = []
    for source in sources:
        source_times.append(source.stat().st_mtime_ns)
    
    return any([s >= target_time for s in source_times])

