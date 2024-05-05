#!/bin/bash

# shellcheck source=$HOME/.bashrc
DOT_BASHRC_PATH="$HOME/.bashrc"
if [ -f "$DOT_BASHRC_PATH" ]; then
	. "$DOT_BASHRC_PATH"
fi
