#!/bin/bash

dataDir="$1"
toDir="$dataDir/Sorted"
if [ -d "$toDir" ]; then
    echo "Directory already exists: $toDir"
elif ! [ -d "$toDir" ]; then
    echo "Creating directory: $toDir"
    mkdir "$toDir"
fi

find "$dataDir" -type f -depth 1 \( -iname "*.out" -o -iname *.err \) | while read fpath
do
    echo "Working on path '$fpath'."
    fname="$(basename "$fpath")"
    newpath="$toDir/$fname"
    echo "  fname: $fname"
    echo "  newpath: $newpath"
    sort "$fpath" > "$newpath"
done