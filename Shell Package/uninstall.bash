#!/usr/bin/env bash

# This script uninstalls the "Herman's Code" Shell package from your system.

# This is done by removing the inserted text in the bash files listed below
#  ".<SHELL_NAME>_logout"
#  ".<SHELL_NAME>_profile"
#  ".<SHELL_NAME>rc"

# Check if a script was sourced or not
# This must be sourced to unset environment variables
sourced=0
if [ -n "$ZSH_VERSION" ]; then 
  case $ZSH_EVAL_CONTEXT in *:file) sourced=1;; esac
elif [ -n "$KSH_VERSION" ]; then
  [ "$(cd -- "$(dirname -- "$0")" && pwd -P)/$(basename -- "$0")" != "$(cd -- "$(dirname -- "${.sh.file}")" && pwd -P)/$(basename -- "${.sh.file}")" ] && sourced=1
elif [ -n "$BASH_VERSION" ]; then
  (return 0 2>/dev/null) && sourced=1 
else # All other shells: examine $0 for known shell binary filenames.
  # Detects `sh` and `dash`; add additional shell filenames as needed.
  case ${0##*/} in sh|-sh|dash|-dash) sourced=1;; esac
fi
if [[ "$sourced" == 1 ]]; then
    :
else
    echo "This script must be run using \"source\" or \".\" in bash or zsh. Other shells are not supported."
    exit 1
fi

# Formatting codes
bld=$(tput bold)
nrl=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

# Define important variables
if [ -z "$HERMANS_CODE_INSTALL_PATH" ]; then
    HERMANS_CODE_INSTALL_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null || return 2>&1; cd .. ; pwd -P )"
    HERMANS_CODE_SHELL_PKG_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package"
else
    :
fi

# Load start and end markers from data directory
fname1="$HERMANS_CODE_SHELL_PKG_PATH/install/data/output/code_block_markers/marker_start.txt"
fname2="$HERMANS_CODE_SHELL_PKG_PATH/install/data/output/code_block_markers/marker_end.txt"
marker1="$(cat "$fname1")"  || return
marker2="$(cat "$fname2")"
marker_array=("$marker1" \
              "$marker2")
echo " >>> These are the start and end markers before escaping >>>"
for marker in "${marker_array[@]}"; do
    echo " - ${RED}$marker${NC}"
done

# Escape special characters in markers.
marker1_escaped="$(printf "%q" "$marker1")"
marker2_escaped="$(printf "%q" "$marker2")"
marker_array_escaped=("$marker1_escaped" \
                      "$marker2_escaped")
echo " <<< These are the start and end markers before escaping <<<"
echo " >>> These are the start and end markers after escaping >>>"
for marker in "${marker_array_escaped[@]}"; do
    echo " - ${RED}$marker${NC}"
done
echo " <<< These are the start and end markers after escaping <<<"

# Iterate over code blocks
while read -r fname;
do
    file_to_edit_path="$HOME/$(basename "$fname")"
    echo ""
    echo "This is the file we are going to edit: ${bld}\"$file_to_edit_path\"${nrl}"
    echo ""
    text_to_edit="$(cat "$file_to_edit_path")"
    echo " >>> This is the text to be edited >>>"
    echo "${BLU}$text_to_edit${NC}"
    echo " <<< This is the text to be edited <<<"
    echo ""
    text_done="$(sed "/$marker1_escaped/,/$marker2_escaped/d" "$file_to_edit_path")"
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
done < <(cat "$HERMANS_CODE_INSTALL_PATH/Shell Package/install/data/output/files/files.txt") || return

# Uninstall symbolic links
MANUAL_ARRAY=("findTraces.bash" \
              "processTraces.bash" \
              "uninstallFromFileList.bash")
echo "Removing script links."
counter=$((0))
for file_path in "$HERMANS_CODE_INSTALL_PATH/Shell Package/scripts/_modules/uninstaller"/*; do
    file_stem="${file_base_name%.*}"
    file_path_to_remove="/Users/$USER/.local/bin/$file_stem"
    if [ -f "$file_path_to_remove" ]; then
        counter+=$(($counter + 1))
        echo -n "  - $file_path_to_remove"
        rm "$file_path_to_remove"
        if [ "$?" ]; then
            echo " ❌"
        else
            echo " ✅"
        fi
    fi
done
if [ $counter -eq 0 ]; then
    echo "No script links to remove."
fi

# Run bash logout
LOGOUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/rc/logout/logout.mash"
echo "Running logout procedure: \"$LOGOUT_PATH\"
"
# shellcheck source="Shell Package/logout/logout.mash"
source "$LOGOUT_PATH"

echo "You will need to restart your shell for the uninstallation effects to be complete.

${bld}End of un-installation${nrl}
"
