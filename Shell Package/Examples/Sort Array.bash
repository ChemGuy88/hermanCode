#!/bin/bash

# An example of how to sort an array.

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

array1=("Element 1-1" "Element 5-2" "Element 1-3")
array2=("Element 2-1" "Element 5-2" "Element 2-3")
array3=("Element 3-1" "Element 5-2" "Element 3-3")

allArrays=()
allArrays+=("${array1[@]}")
allArrays+=("${array2[@]}")
allArrays+=("${array3[@]}")

# Show array elements
echo " >>> Array ${bold}${GRN}before${normal}${NC} sorting >>>"
for path in "${allArrays[@]}";
do
    echo "  $path"
done
echo " <<< Array ${bold}${GRN}before${normal}${NC} sorting <<<"


# Do work
allArraysSorted=()
while read -r line;
do
    allArraysSorted+=("$line");
done < <(printf '%s\n' "${allArrays[@]}" | sort)

# Check work
echo " >>> Array ${bold}${RED}after${normal}${NC} sorting >>>"
for path in "${allArraysSorted[@]}";
do
    echo "  $path"
done
echo " <<< Array ${bold}${RED}after${normal}${NC} sorting <<<"
