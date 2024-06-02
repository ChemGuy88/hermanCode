#!/bin/bash

# An example of how to read file path text to a for-loop.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

file_path="Shell Package/Data/Install/Code Block Files.txt"
TEXT="$(cat "$file_path")"
echo " ${bld}${GRN}>>>${nrl}${NC} This is the file path text being fed to the for-loop ${bld}${GRN}>>>${nrl}${NC}"
echo "$TEXT"
echo " ${bld}${GRN}<<<${nrl}${NC} This is the file path text being fed to the for-loop ${bld}${GRN}<<<${nrl}${NC}"


echo " ${bld}${RED}>>>${nrl}${NC} This is the for-loop segmentation of the file path text ${bld}${RED}>>>${nrl}${NC}"
it=0
while read -r line;
do
    it=$((it+1))
    echo "Line $it: $line"
done < <(cat "$file_path")
echo " ${bld}${RED}<<<${nrl}${NC} This is the for-loop segmentation of the file path text ${bld}${RED}<<<${nrl}${NC}"
