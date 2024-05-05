#!/bin/bash

# shellcheck source="$HERMAN_CODE_DIR/bashrc.bash"
HERMAN_CODE_BASHRC_PATH="$HERMAN_CODE_DIR/bashrc.bash"
if [ -f "$HERMAN_CODE_BASHRC_PATH" ]; then
	. "$HERMAN_CODE_BASHRC_PATH"
fi
