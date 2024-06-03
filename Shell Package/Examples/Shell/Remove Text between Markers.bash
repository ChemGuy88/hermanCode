#!/usr/bin/env bash

# This example removes the text contained between two markers.

# See https://unix.stackexchange.com/questions/192465/remove-paragraph-from-file

# Formatting codes
bld=$(tput bold)
nrl=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

# Script
fname1="Shell Package/Examples/Data/Marker - Start.txt"
fname2="Shell Package/Examples/Data/Marker - End.txt"
marker1="$(cat "$fname1")"
marker2="$(cat "$fname2")"
marker_array=("$marker1" \
              "$marker2")
echo " >>> These are the start and end markers >>>"
for marker in "${marker_array[@]}"; do
    echo " - ${RED}$marker${NC}"
done
echo " <<< These are the start and end markers <<<"
echo ""
file_to_edit_path="Shell Package/Examples/Data/Text between Markers.txt"
echo "This is the file we are going to edit: ${bld}\"$file_to_edit_path\"${nrl}"
echo ""
text_to_edit="$(cat "$file_to_edit_path")"
echo " >>> This is the text to be edited >>>"
echo "${BLU}$text_to_edit${NC}"
echo " <<< This is the text to be edited <<<"
echo ""
text_done="$(sed "/$marker1/,/$marker2/d" "$file_to_edit_path")"
echo " >>> This is the text after editing >>>"
echo "${GRN}$text_done${NC}"
echo " <<< This is the text after editing <<<"
