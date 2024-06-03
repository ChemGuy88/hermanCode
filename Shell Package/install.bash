#!/usr/bin/env bash

# This script installs the "Herman's Code" Shell package to your system.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
BLU=$'\e[0;34m'
NC=$'\e[0m'

# Check if a script is being run as the super-user "SUDO".
# This is necessary to create the script links
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or using \`sudo\`."
    exit 1
fi

# Package paths
HERMANS_CODE_SHELL_PKG_PATH="$(cd -- "$(dirname -- "$0")" >/dev/null || return 2>&1 ; pwd -P )"  # Duplicated across package
HERMANS_CODE_INSTALL_PATH="$(dirname "$HERMANS_CODE_SHELL_PKG_PATH")"

# Install directory definition
install_records_dir="$HERMANS_CODE_SHELL_PKG_PATH/Install"

# >>> Code blocks creation >>>
# Code blocks creation: Load start and end markers from data directory
CODE_BLOCK_MARKER_START="$(cat "$HERMANS_CODE_SHELL_PKG_PATH/Data/Install/Code Block Markers/Marker - Start.txt")"
CODE_BLOCK_MARKER_END="$(cat "$HERMANS_CODE_SHELL_PKG_PATH/Data/Install/Code Block Markers/Marker - End.txt")"

BLOCK_MARKERS_DIR="$install_records_dir/Code Block Markers"
if [[ -d "$BLOCK_MARKERS_DIR" ]]; then
    :
else
    mkdir -p "$BLOCK_MARKERS_DIR"
fi

echo "$CODE_BLOCK_MARKER_START" > "$BLOCK_MARKERS_DIR/Marker - Start.txt"
echo "$CODE_BLOCK_MARKER_END" > "$BLOCK_MARKERS_DIR/Marker - End.txt"

# Code blocks creation: make `.bash_profile` call `.bashrc`.
BASHRC_PATH="$HOME/.bashrc"
CODE_BLOCK_BASH_PROFILE="$(cat <<CODE

$CODE_BLOCK_MARKER_START
# Set "shellcheck" shell version
# shellcheck shell=bash

# Load ".bashrc"
BASHRC_PATH="$BASHRC_PATH"
if [ -f "\$BASHRC_PATH" ]; then
    # shellcheck source="$BASHRC_PATH"
	. "\$BASHRC_PATH"
fi
$CODE_BLOCK_MARKER_END
CODE
)"

# Code blocks creation: make `.bashrc` call "Herman's Code" Shell package.
HERMANS_CODE_BASHRC_PATH="$HERMANS_CODE_SHELL_PKG_PATH/bashrc.bash"
CODE_BLOCK_BASHRC="$(cat <<CODE

$CODE_BLOCK_MARKER_START
# Set "shellcheck" shell version
# shellcheck shell=bash

# Load "Herman's Code" Shell package
HERMANS_CODE_BASHRC_PATH="$HERMANS_CODE_BASHRC_PATH"
if [ -f "\$HERMANS_CODE_BASHRC_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_BASHRC_PATH"
	. "\$HERMANS_CODE_BASHRC_PATH"
fi
$CODE_BLOCK_MARKER_END
CODE
)"

# Code blocks creation: make `.bash_logout` call "Herman's Code" `logout.bash`.
HERMANS_CODE_LOGOUT_PATH="$HERMANS_CODE_SHELL_PKG_PATH/logout.bash"
CODE_BLOCK_BASH_LOGOUT="$(cat <<CODE

$CODE_BLOCK_MARKER_START
# Set "shellcheck" shell version
# shellcheck shell=bash

# Run logout commands
HERMANS_CODE_LOGOUT_PATH="$HERMANS_CODE_LOGOUT_PATH"
if [ -f "\$HERMANS_CODE_LOGOUT_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_LOGOUT_PATH"
	. "\$HERMANS_CODE_LOGOUT_PATH"
fi
$CODE_BLOCK_MARKER_END
CODE
)"
# <<< Code blocks creation <<<

# >>> Code blocks insertion >>>
# Make directory for code blocks.
CODE_BLOCKS_DIR="$install_records_dir/Code Blocks"
if [[ -d "$CODE_BLOCKS_DIR" ]]; then
    :
else
    mkdir -p "$CODE_BLOCKS_DIR"
fi

# Check if `.bash_profile` exists. If not, create it.
BASH_PROFILE_PATH="$HOME/.bash_profile"
if [ -f "$BASH_PROFILE_PATH" ];
then
    echo "$CODE_BLOCK_BASH_PROFILE" >> "$BASH_PROFILE_PATH"
else
    echo "$CODE_BLOCK_BASH_PROFILE" > "$BASH_PROFILE_PATH"
fi
echo "$CODE_BLOCK_BASH_PROFILE" > "$CODE_BLOCKS_DIR/bash_profile"

# Check if `.bashrc` exists. If not, create it.
BASHRC_PATH="$HOME/.bashrc"
if [ -f "$BASHRC_PATH" ];
then
    echo "$CODE_BLOCK_BASHRC" >> "$BASHRC_PATH"
else
    echo "$CODE_BLOCK_BASHRC" > "$BASHRC_PATH"
fi
echo "$CODE_BLOCK_BASHRC" > "$CODE_BLOCKS_DIR/bashrc"

# Check if `.bash_logout` exists. If not, create it.
BASH_LOGOUT_PATH="$HOME/.bash_logout"
if [ -f "$BASH_LOGOUT_PATH" ];
then
    echo "$CODE_BLOCK_BASH_LOGOUT" >> "$BASH_LOGOUT_PATH"
else
    echo "$CODE_BLOCK_BASH_LOGOUT" > "$BASH_LOGOUT_PATH"
fi
echo "$CODE_BLOCK_BASH_LOGOUT" > "$CODE_BLOCKS_DIR/bash_logout"

# <<< Code blocks insertion <<<

# >>> Change ownership of created files >>>
if [[ $SUDO_USER ]];
then
    chown -R "$SUDO_USER" "$install_records_dir"
else
    :
fi
# <<< Change ownership of created files <<<

# >>> Add to `PATH` >>>
# Get list of files to link
MANUAL_ARRAY=("findTraces.bash" \
              "processTraces.bash" \
              "uninstallFromFileList.bash")
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
        ln -s "$file_path" "/usr/local/bin/$file_stem"
    else
        :
    fi
done
# <<< Add to `PATH` <<<

echo "If you did not \`source\` the installation, you will have to restart your shell or run the below command:

${BLU}source ~/.bash_profile${NC}

${bld}End of installation${nrl}
"
