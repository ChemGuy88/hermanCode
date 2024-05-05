#!/bin/bash

# An example of how to remove text from a path containing forward slashes.

# Formatting
BLD=$(tput bold)
NRL=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

# Define input
EXAMPLE_TEXT_INPUT="/System/Volumes/Data/folder/asdf.txt"

# Preview data for processing
echo "   ${BLD}${GRN}>>>${NRL}${NC} This is the text before processing ${BLD}${GRN}>>>${NRL}${NC}"
echo "$EXAMPLE_TEXT_INPUT"
echo "   ${BLD}${GRN}<<<${NRL}${NC} This is the text before processing  ${BLD}${GRN}<<<${NRL}${NC}"

# Process data
EXAMPLE_TEXT_OUTPUT="$(echo "$EXAMPLE_TEXT_INPUT" | sed 's/\/System\/Volumes\/Data//')"

# Print results
echo "   ${BLD}${RED}>>>${NRL}${NC} This is the text after processing ${BLD}${RED}>>>${NRL}${NC}"
echo "$EXAMPLE_TEXT_OUTPUT"
echo "   ${BLD}${RED}<<<${NRL}${NC} This is the text after processing  ${BLD}${RED}<<<${NRL}${NC}"
