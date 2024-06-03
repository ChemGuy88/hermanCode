#!/usr/bin/env bash

# An example workflow for uninstalling traces on macOS

# Step 1: GUI approach
# Uninstall programs by clicking and dragging from the "Applications" folder in Finder to the Trash bin.

# Step 2: Uninstall programs using `pkgutil`
pkgutil --pkgs | grep -i "PROGRAM_NAME" | sort

# Step 2: Option 1: Single package option
# Use `uninstallWithPkgutil.bash`
:

# Step 2: Option 1: Multiple package option
# Use `uninstallWithPkgutil-Multiple.bash`
:

# Step 3: Find trces
findTraces.bash -t FALSE -k app1 -k app2

# >>> Step 4: Process traces >>>
# Step 4: Process traces: Option 1: Process one result
processTraces.bash -t FALSE -f "Find Traces/YYYY-MM-DD hh-mm-ss"
# Step 4: Process traces: Option 1: Process multipel results
find "Find Traces/YYYY-MM-DD hh-mm-ss" -type f -iname "*.out" -exec echo '{}' \;  # Test path
find "YYYY-MM-DD hh-mm-ss" -maxdepth 1 -type f -iname "*.out" -exec processTraces -d TRUE \
                                                                                  -t FALSE \
                                                                                  -l "/Users/exampleUser/.Trash/" \
                                                                                  -l "/Users/exampleUser/Find Traces/" \
                                                                                  -f '{}' \;  # Execute processing

# <<< Step 4: Process traces <<<

# >>> Step 5: Remove traces <<<
dir_from="YYYY-MM-DD hh-mm-ss/Processed"
dir_to="YYYY-MM-DD hh-mm-ss/Remove Traces Result 1"  # Repeat as necessary
find "$dir_from" -maxdepth 1 \
                 -type f \
                 -iname "*.out" > file1.text
while read -r line;
do
    file_stem="$(getFilestem "$line")"
    file_path="$dir_from/$file_stem.out"
    file_path_out="$dir_to/$file_stem.out"
    uninstallFromFileList -d "FALSE" \
                          -f "$file_path" \
                          -o "$file_path_out" \
                          -t "FALSE"
done < <(cat file1.text)
# >>> Step 5: Remove traces <<<
