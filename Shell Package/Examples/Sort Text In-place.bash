#!/bin/bash

# This is an example of how to sort text in-place instead of saving it to a file.

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

echo " >>> Text ${bold}${GRN}Before${normal}${NC} Sorting >>>"
TEXT=$'a\nx\nc'
echo "$TEXT"
echo " <<< Text ${bold}${GRN}Before${normal}${NC} Sorting <<<"
export TEXT

# Sort in place
echo " >>> Text ${bold}${RED}After${normal}${NC} Sorting >>>"
sort -r <<<"$TEXT"
echo " <<< Text ${bold}${RED}After${normal}${NC} Sorting <<<"

# Sort in place and export result
RESULT1=$(sort -r <<<"$TEXT")
export RESULT1

# Sort in place and then store in array
array=()
while read -r line;
do
    array+=("$line");
done < <(sort <<<"$TEXT")

# Loop over array
echo " >>> Sorted text results stored in array >>>"
it=0
for el in "${array[@]}"; do
    it=$((it+1))
    echo "Line $it: $el"
done
echo " <<< Sorted text results stored in array <<<"
