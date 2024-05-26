#!/usr/bin/env bash

# This script uninstalls the "Herman's Code" Shell package from your system.

# This is done by removing the inserted text in the bash files listed below
#  ".bash_logout"
#  ".bash_profile"
#  ".bashrc"

# For file in "Shell Package/Install/Code Blocks"
#   The name of the file is also the name of the bash file from which to remove inserted text
#   Read file
#   Remove text

RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

for fname in "$HERMANS_CODE_INSTALL_PATH/Shell Package/Install/Code Blocks"/*; do
    text_to_remove="$(cat "$fname")"
    echo " >>> This is the text to be removed >>>"
    echo "${RED}$text_to_remove${NC}"
    echo " <<< This is the text to be removed <<<"
    echo ""
    file_to_edit_path="$HOME/.$(basename "$fname")"
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
done
