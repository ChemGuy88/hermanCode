#!/bin/bash

source /Users/herman/.hermanCode/macOS/functions.bash

FIND_TRACES_DIRECTORY=~/"Find Traces/$(getTimestamp)"
if ! [ -d "$FIND_TRACES_DIRECTORY" ]; then
    mkdir -p "$FIND_TRACES_DIRECTORY"
    echo "Made directory at $FIND_TRACES_DIRECTORY"
elif [ -d "$FIND_TRACES_DIRECTORY" ]; then
    echo "Directory already exists: $FIND_TRACES_DIRECTORY"
fi

echo "This directory was created by 'findTraces.sh'" > "$FIND_TRACES_DIRECTORY/README.md"

nohup find / -iname *mactex* 1> "$FIND_TRACES_DIRECTORY/mactex.out" 2> "$FIND_TRACES_DIRECTORY/mactex.err" &
# nohup find / -iname *matlab* 1> "$FIND_TRACES_DIRECTORY/matlab.out" 2> "$FIND_TRACES_DIRECTORY/matlab.err" &
# nohup find / -iname *qgl* 1> "$FIND_TRACES_DIRECTORY/libQGL.out" 2> "$FIND_TRACES_DIRECTORY/libQGL.err" &
# nohup find / -iname *weka* 1> "$FIND_TRACES_DIRECTORY/weka.out" 2> "$FIND_TRACES_DIRECTORY/weka.err" &
# nohup find / -iname *anaconda* 1> "$FIND_TRACES_DIRECTORY/anaconda.out" 2> "$FIND_TRACES_DIRECTORY/anaconda.err" &
# nohup find / \(! -iname *atomic* -iname *atom*\) 1> "$FIND_TRACES_DIRECTORY/atom.out" 2> "$FIND_TRACES_DIRECTORY/anaconda.err" &
# nohup find / \(! -iname *miniconda* ! -iname *anaconda* -iname *conda*\) 1> "$FIND_TRACES_DIRECTORY/conda.out" 2> "$FIND_TRACES_DIRECTORY/anaconda.err" &
# nohup find / \( -iname *brew* ! -iname *hebrew* \) 1> "$FIND_TRACES_DIRECTORY/homebrew.out" 2> "$FIND_TRACES_DIRECTORY/homebrew.err" &
# nohup find / -iname *miniconda* 1> "$FIND_TRACES_DIRECTORY/miniconda.out" 2> "$FIND_TRACES_DIRECTORY/miniconda.err" &
# nohup find / \( -iname *R-project* \) 1> "$FIND_TRACES_DIRECTORY/R-project.out" 2> "$FIND_TRACES_DIRECTORY/R-project.err" &

echo "Script is running"