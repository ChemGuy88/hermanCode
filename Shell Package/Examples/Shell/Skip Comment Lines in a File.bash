#!/usr/bin/env bash

# An example of how to skip comment lines in a file, that is,
# lines starting with a "#" character.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

TEXT=$(cat "Shell Package/macOS/Examples/Data/Comment Lines in a File.txt")
# TEXT=$'This is line 1, the first line.\n# This is a commented line followed by a blank line.\n\n# The previous line was blank!\nThis is another line.'

echo " ${bld}${GRN}>>>${nrl}${NC} This is the text being fed to the for loop ${bld}${GRN}>>>${nrl}${NC}"
echo "$TEXT"
echo " ${bld}${GRN}<<<${nrl}${NC} This is the text being fed to the for loop ${bld}${GRN}<<<${nrl}${NC}"

# Read all lines
echo " ${bld}${BLU}>>>${nrl}${NC} Segmentation of the text ${bld}${BLU}>>>${nrl}${NC}"
it=0
while read -r line
do
    it=$((it+1))
    echo "  Line $it: \"$line\""
done < <(echo "$TEXT")
echo " ${bld}${BLU}<<<${nrl}${NC} Segmentation of the text ${bld}${BLU}<<<${nrl}${NC}"

# Skip lines commented with "#" or empty lines
echo " ${bld}${RED}>>>${nrl}${NC} Selective reading of the text ${bld}${RED}>>>${nrl}${NC}"
while read -r line
do 
    echo "  Working on \"$line\""
done < <(echo "$TEXT" | grep -v -e '^#' -e '^$')
echo " ${bld}${RED}<<<${nrl}${NC} Selective reading of the text ${bld}${RED}<<<${nrl}${NC}"
