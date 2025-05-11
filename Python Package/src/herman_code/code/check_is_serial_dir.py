"""
"""

import re
from pathlib import Path

PATTERN = r"^[0]{0,}[0-9]+$"


def check_is_serial_dir(path_obj: Path) -> bool:
    """
    Checks if a path is a zero-padded integer.
    """
    if path_obj.is_dir():
        pass
    else:
        return False
    
    match_obj = re.match(pattern=PATTERN,
                         string=path_obj.name)
    
    if match_obj:
        return True
    else:
        return False
