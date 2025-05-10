"""
Exploring subgroup handling with regular expressions.
"""

import re
from pprint import pprint

t1 = """
This is your government ID

name: Albert Gator
age: 100

Thanks for being a Citizen!
"""

p1 = r"""(?msx:
         \A
         \n
         (?P<boilerplate>This\ is\ your\ government\ ID)\n
         \n
         name:\ (?P<name>.+)\n
         age:\ (?P<age>\d+)\n
         \n
         Thanks\ for\ being\ a\ Citizen!\n
         \Z
         )"""

p1 = r"""(?msx:
         \A
         \n
         (?P<boilerplate>This\ is\ your\ government\ ID\n
         \n
         name:\ (?:(?P<name>.+))\n
         age:\ (?P<age>\d+)\n
         \n
         Thanks\ for\ being\ a\ Citizen!\n
         )
         \Z
         )"""

r1 = re.match(pattern=p1, string=t1)

if r1:
    print(r1.groups())
    pprint(r1.groupdict())
else:
    print(r1)
