#!/usr/bin/env bash

# This script installs the "Herman's Code" Shell package to your system.

# Package paths
HERMANS_CODE_SHELL_PKG_PATH="$(cd -- "$(dirname "$0")" >/dev/null || return 2>&1 ; pwd -P )"  # Duplicated across package
# HERMANS_CODE_INSTALL_PATH="$(dirname "$HERMANS_CODE_SHELL_PKG_PATH")"

# Code blocks creation
# Make `.bash_profile` call `.bashrc`.
BASHRC_PATH="$HOME/.bashrc"
CODE_BLOCK_BASH_PROFILE="$(cat <<CODE

# >>> This code block was put here by the "Herman's Code" Shell package >>>
# Set "shellcheck" shell version
# shellcheck shell=bash

# Load ".bashrc"
BASHRC_PATH="$BASHRC_PATH"
if [ -f "\$BASHRC_PATH" ]; then
    # shellcheck source="$BASHRC_PATH"
	. "\$BASHRC_PATH"
fi
# <<< This code block was put here by the "Herman's Code" Shell package <<<
CODE
)"

# Make `.bashrc` call "Herman's Code" Shell package.
HERMANS_CODE_BASHRC_PATH="$HERMANS_CODE_SHELL_PKG_PATH/bashrc.bash"
CODE_BLOCK_BASHRC="$(cat <<CODE

# >>> This code block was put here by the "Herman's Code" Shell package >>>
# Set "shellcheck" shell version
# shellcheck shell=bash

# Load "Herman's Code" Shell package
HERMANS_CODE_BASHRC_PATH="$HERMANS_CODE_BASHRC_PATH"
if [ -f "\$HERMANS_CODE_BASHRC_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_BASHRC_PATH"
	. "\$HERMANS_CODE_BASHRC_PATH"
fi
# <<< This code block was put here by the "Herman's Code" Shell package <<<
CODE
)"

# Make `.bash_logout` call "Herman's Code" `logout.bash`.
HERMANS_CODE_LOGOUT_PATH="$HERMANS_CODE_SHELL_PKG_PATH/logout.bash"
CODE_BLOCK_BASH_LOGOUT="$(cat <<CODE

# >>> This code block was put here by the "Herman's Code" Shell package >>>
# Set "shellcheck" shell version
# shellcheck shell=bash

# Run logout commands
HERMANS_CODE_LOGOUT_PATH="$HERMANS_CODE_LOGOUT_PATH"
if [ -f "\$HERMANS_CODE_LOGOUT_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_LOGOUT_PATH"
	. "\$HERMANS_CODE_LOGOUT_PATH"
fi
# <<< This code block was put here by the "Herman's Code" Shell package <<<
CODE
)"

# Code blocks insertion
# Check if `.bash_profile` exists. If not, create it.
BASH_PROFILE_PATH="$HOME/.bash_profile"
if [ -f "$BASH_PROFILE_PATH" ];
then
    echo "$CODE_BLOCK_BASH_PROFILE" >> "$BASH_PROFILE_PATH"
else
    echo "$CODE_BLOCK_BASH_PROFILE" > "$BASH_PROFILE_PATH"
fi
echo "$CODE_BLOCK_BASH_PROFILE" > "$HERMANS_CODE_SHELL_PKG_PATH/Install/Code Blocks/bash_profile"

# Check if `.bashrc` exists. If not, create it.
BASHRC_PATH="$HOME/.bashrc"
if [ -f "$BASHRC_PATH" ];
then
    echo "$CODE_BLOCK_BASHRC" >> "$BASHRC_PATH"
else
    echo "$CODE_BLOCK_BASHRC" > "$BASHRC_PATH"
fi
echo "$CODE_BLOCK_BASHRC" > "$HERMANS_CODE_SHELL_PKG_PATH/Install/Code Blocks/bashrc"

# Check if `.bash_logout` exists. If not, create it.
BASH_LOGOUT_PATH="$HOME/.bash_logout"
if [ -f "$BASH_LOGOUT_PATH" ];
then
    echo "$CODE_BLOCK_BASH_LOGOUT" >> "$BASH_LOGOUT_PATH"
else
    echo "$CODE_BLOCK_BASH_LOGOUT" > "$BASH_LOGOUT_PATH"
fi
echo "$CODE_BLOCK_BASH_LOGOUT" > "$HERMANS_CODE_SHELL_PKG_PATH/Install/Code Blocks/bash_logout"
