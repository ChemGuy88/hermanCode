#!/usr/bin/env bash

# Check if a script was sourced or not: Simple version
echo "Your 0th argument is \"$0\""
if [ "$0" == "-bash" ] || [ "$0" == "bash" ]; then
    :
else
    echo "This script must be run using \"source\" or \".\""
    exit 1
fi

# Check if a script was sourced or not: Robust, portable version
# H/t "https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced"
:
