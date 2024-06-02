#!/usr/bin/env bash

# An example workflow for uninstalling traces on macOS

# Step 1: Find trces
findTraces.bash -t FALSE -k myapp1 -k myapp2

# Step 2: Process traces: Option 1: Process one result
processTraces.bash -t FALSE -f "Find Traces/YYYY-MM-DD hh-mm-ss"
# Step 2: Process traces: Option 1: Process multipel results
find "Find Traces/YYYY-MM-DD hh-mm-ss" -type f -iname "*.out" -exec echo '{}' \;  # Test path
find "2024-03-23 21-58-19 copy" -maxdepth 1 -type f -iname "*.out" -exec processTraces -d TRUE \
                                                                                       -t FALSE \
                                                                                       -l "/Users/herman/.Trash/" \
                                                                                       -l "/Users/herman/Find Traces/" \
                                                                                       -f '{}' \;  # Execute processing
