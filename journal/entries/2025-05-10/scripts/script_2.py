"""
Expand Git commit message parser to include the following section format:

```
# On branch main
# Your branch is ahead of 'origin/main' by 1 commit.
#   (use "git push" to publish your local commits)
#
```
"""

import pprint as pp
import re

from herman_code.code.wrap import wrap

t1 = """

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch main
# Your branch is up to date with 'origin/main'.
#
# Changes to be committed:
"""

t2 = """

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch main
# Your branch is ahead of 'origin/main' by 1 commit.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:
"""

t3 = """

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch main
# Your branch is ahead of 'origin/main' by 2 commits.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:
"""

p1 = r"""(?msx:
         \A
         (?:\W+)?
         (?P<boilerplate>
         \#\ Please\ enter\ the\ commit\ message\ for\ your\ changes\.\ Lines\ starting\n
         \#\ with\ '\#'\ will\ be\ ignored,\ and\ an\ empty\ message\ aborts\ the\ commit\.\n
         \#\n)
         \#\ On\ branch\ 
         (?P<branch_name>.+)\n
         \#\ Your\ branch\ is\ 
         (?P<branch_status>.+)\ 
         (?:with|of)\ '
         (?P<remote_branch>.+)'
         (\ by\ 
         (?P<num_commits>\d+)
         \ commit[s]?)?
         \.\n
         (\#\ \ \ \(use\ "git\ push"\ to\ publish\ your\ local\ commits\)\n)?
         \#\n
         \#\ Changes\ to\ be\ committed:\n
         \Z
         )"""

fp = "/Users/midas/Documents/midas/COMMIT_EDITMSG"

for tt in [t1, t2, t3]:
    rr = re.search(pattern=p1, string=tt)

    if rr:
        print(rr.groups())
        print(wrap(pp.pformat(rr.groupdict())))
    else:
        print(rr)
