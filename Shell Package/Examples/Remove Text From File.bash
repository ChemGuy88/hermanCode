#!/usr/bin/env bash

RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

fname="Shell Package/Examples/Data/Text to Remove.txt"
text_to_remove="$(cat "$fname")"
echo " >>> This is the text to be removed >>>"
echo "${RED}$text_to_remove${NC}"
echo " <<< This is the text to be removed <<<"
echo ""
file_to_edit_path="Shell Package/Examples/Data/File to Edit.txt"
echo "This is the file we are going to edit: \"$file_to_edit_path\""
echo ""
text_to_edit="$(cat "$file_to_edit_path")"
echo " >>> This is the text to be edited >>>"
echo "${BLU}$text_to_edit${NC}"
echo " <<< This is the text to be edited <<<"
echo ""
text_done="$(sed -e "s/$text_to_remove//g" "$file_to_edit_path")"
echo " >>> This is the text after editing >>>"
echo "${GRN}$text_done${NC}"
echo " <<< This is the text after editing <<<"
