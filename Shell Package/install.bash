#!/bin/bash

# This script install the "Herman's Code" Shell package to your system.

# Code block creation
# Make `.bash_profile` call `.bashrc`. Check if `.bash_profile` exists. If not, create it.
BASH_PROFILE_PATH="$HOME/.bash_profile"
CODE_BLOCK_BASH_PROFILE="$(cat <<CODE
>>> This code block was put here by the "Herman's Code" Shell package >>>
# Load ".bashrc"
BASH_PROFILE_PATH="$BASH_PROFILE_PATH"
if [ -f "\$BASH_PROFILE_PATH" ]; then
    # shellcheck source="$BASH_PROFILE_PATH"
	. "\$BASH_PROFILE_PATH"
fi
<<< This code block was put here by the "Herman's Code" Shell package <<<
CODE
)"

# Make `.bashrc` call "Herman's Code" Shell package. Check if `.bashrc` exists. If not, create it.
HERMANS_CODE_INSTALL_PATH="$(pwd)"
CODE_BLOCK_BASHRC="$(cat <<CODE
>>> This code block was put here by the "Herman's Code" Shell package >>>
# Load "Herman's Code" Shell package
HERMANS_CODE_INSTALL_PATH="$HERMANS_CODE_INSTALL_PATH"
if [ -f "\$HERMANS_CODE_INSTALL_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_INSTALL_PATH"
	. "\$HERMANS_CODE_INSTALL_PATH"
fi
<<< This code block was put here by the "Herman's Code" Shell package <<<
CODE
)"

# Make `.bash_logout` call "Herman's Code" `logout.bash`. Check if `.bash_logout` exists. If not, create it.
BASH_LOGOUT_PATH="$HOME/.bash_logout"
CODE_BLOCK_BASH_LOGOUT="$(cat <<CODE
>>> This code block was put here by the "Herman's Code" Shell package >>>
BASH_LOGOUT_PATH="$BASH_LOGOUT_PATH"
if [ -f "\$BASH_LOGOUT_PATH" ]; then
    # shellcheck source="$BASH_LOGOUT_PATH"
	. "\$BASH_LOGOUT_PATH"
fi
<<< This code block was put here by the "Herman's Code" Shell package <<<
CODE
)"

# Code block insertion
if [ -f "$BASH_PROFILE_PATH" ];
then
    echo "$CODE_BLOCK_BASH_PROFILE" >> "$BASH_PROFILE_PATH"
else
    echo "$CODE_BLOCK_BASH_PROFILE" > "$BASH_PROFILE_PATH"
fi

BASHRC_PATH="$HOME/.bashrc"
if [ -f "$BASHRC_PATH" ];
then
    echo "$CODE_BLOCK_BASHRC" >> "$BASHRC_PATH"
else
    echo "$CODE_BLOCK_BASHRC" > "$BASHRC_PATH"
fi

BASH_LOGOUT_PATH="$HOME/.bash_logout"
if [ -f "$BASH_LOGOUT_PATH" ];
then
    echo "$CODE_BLOCK_BASH_LOGOUT" >> "$BASH_LOGOUT_PATH"
else
    echo "$CODE_BLOCK_BASH_LOGOUT" > "$BASH_LOGOUT_PATH"
fi


