#!/usr/bin/env bash

# Print each argument passed

if [ -z "$*" ]; then
    echo "No arguments were passed"
else
    echo "Printing each argument iteratively:"
    it=0
    for argument in "$@"; do
        it=$((it+1))
        echo " $it - $argument"
    done
    echo ""

    echo "Printing all arguments at once: \"${*}\""
fi
