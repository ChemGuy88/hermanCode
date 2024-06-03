#!/bin/bash

# An example of how to remove text from a path containing forward slashes.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

# Define input
EXAMPLE_TEXT_INPUT="/System/Volumes/Data/folder/asdf.txt"

# Preview data for processing
echo "   ${bld}${GRN}>>>${nrl}${NC} This is the text before processing ${bld}${GRN}>>>${nrl}${NC}"
echo "$EXAMPLE_TEXT_INPUT"
echo "   ${bld}${GRN}<<<${nrl}${NC} This is the text before processing  ${bld}${GRN}<<<${nrl}${NC}"

# Process data
EXAMPLE_TEXT_OUTPUT="$(echo "$EXAMPLE_TEXT_INPUT" | sed 's/\/System\/Volumes\/Data//')"

# Print results
echo "   ${bld}${RED}>>>${nrl}${NC} This is the text after processing ${bld}${RED}>>>${nrl}${NC}"
echo "$EXAMPLE_TEXT_OUTPUT"
echo "   ${bld}${RED}<<<${nrl}${NC} This is the text after processing  ${bld}${RED}<<<${nrl}${NC}"
