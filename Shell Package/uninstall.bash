#!/usr/bin/env bash

# This script uninstalls the "Herman's Code" Shell package from your system.

# This is done by removing the inserted text in the bash files listed below
#  ".bash_logout"
#  ".bash_profile"
#  ".bashrc"

# Check if a script was sourced or not
# This must be sourced to unset environment variables
if [ "$0" == "-bash" ] || [ "$0" == "bash" ]; then
    :
else
    echo "This script must be run using \"source\" or \".\""
    exit 1
fi

# Formatting codes
bld=$(tput bold)
nrl=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

# Load start and end markers from data directory
fname1="$HERMANS_CODE_SHELL_PKG_PATH/Data/Install/Code Block Markers/Marker - Start.txt"
fname2="$HERMANS_CODE_SHELL_PKG_PATH/Data/Install/Code Block Markers/Marker - End.txt"
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
while read -r fname;
do
    file_to_edit_path="$HOME/.$(basename "$fname")"
    echo ""
    echo "This is the file we are going to edit: ${bld}\"$file_to_edit_path\"${nrl}"
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
        echo " >>> This is the text after editing ${GRN}(Note the result is an empty string)${NC} >>>"
        echo " <<< This is the text after editing ${GRN}(Note the result is an empty string)${NC} <<<"
    else
        echo " >>> This is the text after editing >>>"
        echo "${GRN}$text_done_read${NC}"
        echo " <<< This is the text after editing <<<"
    fi
done < <(cat "$HERMANS_CODE_INSTALL_PATH/Shell Package/Data/Install/Code Block Files.txt")

# Uninstall symbolic links
MANUAL_ARRAY=("findTraces.bash" \
              "processTraces.bash")
for file_path in "$HERMANS_CODE_INSTALL_PATH/Shell Package/macOS/uninstallers"/*; do
    :
    file_base_name="$(basename -- "$file_path")"
    counter=0
    for array_value in "${MANUAL_ARRAY[@]}"; do
        if [ "$file_base_name" == "$array_value" ]; then
            counter=$((counter+1))
        else
            :
        fi
    done
    if [ "$counter" -gt 0 ]; then
        file_stem="${file_base_name%.*}"
        file_path_to_remove="/usr/local/bin/$file_stem"
        if [ -f "$file_path_to_remove" ]; then
            rm "$file_path_to_remove"
        else
            :
        fi
    else
        :
    fi
done

# Run bash logout
LOGOUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/logout.bash"
echo "Running logout procedure: \"$LOGOUT_PATH\"
"
# shellcheck source="Shell Package/logout.bash"
source "$LOGOUT_PATH"

echo "You will need to restart your shell for the uninstallation effects to be complete.

${bld}End of installation${nrl}
"
