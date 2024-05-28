#!/usr/bin/env bash

# This script uninstalls the "Herman's Code" Shell package from your system.

# This is done by removing the inserted text in the bash files listed below
#  ".bash_logout"
#  ".bash_profile"
#  ".bashrc"

# Formatting codes
BLD=$(tput bold)
NRL=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

# Load start and end markers
fname1="$HERMANS_CODE_INSTALL_PATH/Shell Package/Install/Code Block Markers/Marker - Start.txt"
fname2="$HERMANS_CODE_INSTALL_PATH/Shell Package/Install/Code Block Markers/Marker - End.txt"
marker1="$(cat "$fname1")"
marker2="$(cat "$fname2")"
marker_array=("$marker1" \
            "$marker2")
echo " >>> These are the start and end markers >>>"
for marker in "${marker_array[@]}"; do
    echo " - ${RED}$marker${NC}"
done
echo " <<< These are the start and end markers <<<"
# Iterate over code blocks
for fname in "$HERMANS_CODE_INSTALL_PATH/Shell Package/Install/Code Blocks"/*; do
    file_to_edit_path="$HOME/.$(basename "$fname")"
    echo ""
    echo "This is the file we are going to edit: ${BLD}\"$file_to_edit_path\"${NRL}"
    echo ""
    text_to_edit="$(cat "$file_to_edit_path")"
    echo " >>> This is the text to be edited >>>"
    echo "${BLU}$text_to_edit${NC}"
    echo " <<< This is the text to be edited <<<"
    echo ""
    text_done="$(sed "/$marker1/,/$marker2/d" "$file_to_edit_path")"
    echo "$text_done" > "$file_to_edit_path"
    text_done_read="$(cat "$file_to_edit_path")"
    if [ -z "$text_done_read" ]; then
        echo " >>> This is the text after editing (Note the result is an empty string) >>>"
        echo " <<< This is the text after editing (Note the result is an empty string) <<<"
    else
        echo " >>> This is the text after editing >>>"
        echo "${GRN}$text_done_read${NC}"
        echo " <<< This is the text after editing <<<"
    fi
done
