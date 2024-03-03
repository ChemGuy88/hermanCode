#!/bin/bash
# To make this a bash executable, run
# sudo chmod 755 <pathto/thisfile>
#
# This script is based on the recommendations from
# https://stackoverflow.com/questions/42182706/how-to-uninstall-anaconda-completely-from-macos
#
# Comment abbreviations:
# rs : requires sudo
# nf : not found
# d  : not in kb article, but found in the directory, and deleted just in case.

######################################################################
## Code block, find the directory named python* and delete it. #######
######################################################################

message="Searching for \"python\" in the user directory: $USER"
echo $message

timestamp=$(date +%Y-%m-%d_%H-%M-%S)
fpath="uninstallPython_paths_$timestamp.txt"
if [ -f "$fpath" ]
then
     :
elif [ ! -f "$fpath" ]
then
     touch "$fpath"
     echo "Created file at \"$fpath\""
fi

find ~/ \( -name python* -o -name .python* -o -name python*.* -o -name *python*.* \) >> $fpath 2>&1

python3 uninstallPython/uninstallPython.py "$fpath"

######################################################################
## Code block, #######################################################
######################################################################

echo You need to check \".bashrc\" and/or \".bash_profile\" to remove any modifications to \$PATH.

echo Uninstall complete.
