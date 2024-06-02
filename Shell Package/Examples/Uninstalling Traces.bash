#!/usr/bin/env bash

# An example workflow for uninstalling traces on macOS

# Step 1: Find trces
findTraces.bash -t FALSE -k myapp1 -k myapp2

# Step 2: Process traces: Option 1: Process one result
processTraces.bash -t FALSE -f "Find Traces/YYYY-MM-DD hh-mm-ss"
# Step 2: Process traces: Option 1: Process multipel results
find "Find Traces/YYYY-MM-DD hh-mm-ss" -type f -iname "*.out" -exec echo '{}' \;  # Test path
find "Find Traces/YYYY-MM-DD hh-mm-ss" -type f -iname "*.out" -exec processTraces '{}' \;  # Execute processing
