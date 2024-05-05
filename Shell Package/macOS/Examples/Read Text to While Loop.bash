#!/bin/bash

# An example of how to read text to a while-loop.

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

TEXT=$'a\nx\nc'
echo " ${bold}${GRN}>>>${normal}${NC} This is the text being fed to the for-loop ${bold}${GRN}>>>${normal}${NC}"
echo "$TEXT"
echo " ${bold}${GRN}<<<${normal}${NC} This is the text being fed to the for-loop ${bold}${GRN}<<<${normal}${NC}"


echo " ${bold}${RED}>>>${normal}${NC} This is the for-loop segmentation of the text ${bold}${RED}>>>${normal}${NC}"
it=0
while read -r line;
do
    it=$((it+1))
    echo "Line $it: $line"
done < <(echo "$TEXT")
echo " ${bold}${RED}<<<${normal}${NC} This is the for-loop segmentation of the text ${bold}${RED}<<<${normal}${NC}"
