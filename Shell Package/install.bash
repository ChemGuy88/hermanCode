#!/usr/bin/env bash

# This script installs the "Herman's Code" Shell package to your system.

# Package paths
HERMANS_CODE_SHELL_PKG_PATH="$(cd -- "$(dirname "$0")" >/dev/null || return 2>&1 ; pwd -P )"  # Duplicated across package

# Code blocks creation
# Code blocks creation: Define start and end markers that will be used for documentation and possible later uninstallation
CODE_BLOCK_MARKER_START="# >>> Contents within this block are managed by \"Herman's Code\" Shell package >>>"
CODE_BLOCK_MARKER_END="# <<< Contents within this block are managed by \"Herman's Code\" Shell package <<<"

BLOCK_MARKERS_DIR="$HERMANS_CODE_SHELL_PKG_PATH/Install/Code Block Markers"
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

# Code blocks insertion

# Make directory for code blocks.
CODE_BLOCKS_DIR="$HERMANS_CODE_SHELL_PKG_PATH/Install/Code Blocks"
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
