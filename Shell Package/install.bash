#!/usr/bin/env bash

# This script installs the "Herman's Code" Shell package to your system.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
BLU=$'\e[0;34m'
NC=$'\e[0m'

usage0() {
    cat <<USAGE
This script installs the "Herman's Code" shell package to your system.

$(basename "$0") -s <shell_name>

    -s The shell name. Currently only \`bash\` or \`zsh\` as supported.
USAGE
}
usage() {
    usage0 1>&2
    exit 1
}

while getopts ":s:" opt; do
    case "${opt}" in
        s) shell_name=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

# >>> Argument confirmation >>>
# `shell_name`
if [[ "$shell_name" =~ (bash|zsh) ]]; then
    :
else
    usage
fi

echo "'shell_name': $shell_name"
# <<< Argument confirmation <<<

# Package paths
HERMANS_CODE_SHELL_PKG_PATH="$(cd -- "$(dirname -- "$0")" >/dev/null || return 2>&1 ; pwd -P )"  # Duplicated across package
HERMANS_CODE_INSTALL_PATH="$(dirname "$HERMANS_CODE_SHELL_PKG_PATH")"

# Define shell profile file names.
if [[ "$shell_name" == "bash" ]]; then
    shell_logout=".$shell_name"_logout
elif [[ "$shell_name" == "zsh" ]]; then
    shell_logout=".zlogout"
fi
shell_profile=".$shell_name"_profile  # profile file
shell_rc=".$shell_name"rc  # RC file

shell_profile_file_names_array=("$shell_logout" \
                                "$shell_profile" \
                                "$shell_rc")

# Write shell profile file names to file
code_block_file_names_file_path="$HERMANS_CODE_INSTALL_PATH/Shell Package/Install/Code Block Files.txt"
code_block_file_names_dir="$(dirname "$code_block_file_names_file_path")"
if [[ -d "$code_block_file_names_dir" ]]; then
    :
else
    mkdir -p "$code_block_file_names_dir"
fi

touch "$code_block_file_names_file_path"
for file_name in "${shell_profile_file_names_array[@]}"; do
    echo "$file_name" >> "$code_block_file_names_file_path"
done

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

# Code blocks creation: make profile file call RC file.
SHELLRC_PATH="$HOME/$shell_rc"
CODE_BLOCK_SHELL_PROFILE="$(cat <<CODE

$CODE_BLOCK_MARKER_START
# Set "shellcheck" shell version
# shellcheck shell=$shell_name

# Load "$shell_rc"
SHELLRC_PATH="$SHELLRC_PATH"
if [ -f "\$SHELLRC_PATH" ]; then
    # shellcheck source="$SHELLRC_PATH"
	. "\$SHELLRC_PATH"
fi
$CODE_BLOCK_MARKER_END
CODE
)"

# Code blocks creation: make RC file call "Herman's Code" Shell package.
HERMANS_CODE_SHELLRC_PATH="$HERMANS_CODE_SHELL_PKG_PATH/rc/login/login.mash"
CODE_BLOCK_SHELLRC="$(cat <<CODE

$CODE_BLOCK_MARKER_START
# Set "shellcheck" shell version
# shellcheck shell=$shell_name

# Load "Herman's Code" Shell package
HERMANS_CODE_SHELLRC_PATH="$HERMANS_CODE_SHELLRC_PATH"
if [ -f "\$HERMANS_CODE_SHELLRC_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_SHELLRC_PATH"
	. "\$HERMANS_CODE_SHELLRC_PATH"
fi
$CODE_BLOCK_MARKER_END
CODE
)"

# Code blocks creation: make logout file call "Herman's Code" `logout.mash`.
HERMANS_CODE_LOGOUT_PATH="$HERMANS_CODE_SHELL_PKG_PATH/rc/logout/logout.mash"
CODE_BLOCK_SHELL_LOGOUT="$(cat <<CODE

$CODE_BLOCK_MARKER_START
# Set "shellcheck" shell version
# shellcheck shell=$shell_name

# Run logout commands
HERMANS_CODE_LOGOUT_PATH="$HERMANS_CODE_LOGOUT_PATH"
if [ -f "\$HERMANS_CODE_LOGOUT_PATH" ]; then
    # shellcheck source="$HERMANS_CODE_LOGOUT_PATH"
	. "\$HERMANS_CODE_LOGOUT_PATH"
else
    echo "MASH: Warning: ($LINENO): Safety mechanism failed."
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

# Check if profile file exists. If not, create it.
SHELL_PROFILE_PATH="$HOME/$shell_profile"
if [ -f "$SHELL_PROFILE_PATH" ];
then
    echo "$CODE_BLOCK_SHELL_PROFILE" >> "$SHELL_PROFILE_PATH"
else
    echo "$CODE_BLOCK_SHELL_PROFILE" > "$SHELL_PROFILE_PATH"
fi
echo "$CODE_BLOCK_SHELL_PROFILE" > "$CODE_BLOCKS_DIR/$shell_profile"

# Check if RC file exists. If not, create it.
SHELLRC_PATH="$HOME/$shell_rc"
if [ -f "$SHELLRC_PATH" ];
then
    echo "$CODE_BLOCK_SHELLRC" >> "$SHELLRC_PATH"
else
    echo "$CODE_BLOCK_SHELLRC" > "$SHELLRC_PATH"
fi
echo "$CODE_BLOCK_SHELLRC" > "$CODE_BLOCKS_DIR/$shell_profile"

# Check if logout file exists. If not, create it.
SHELL_LOGOUT_PATH="$HOME/$shell_logout"
if [ -f "$SHELL_LOGOUT_PATH" ];
then
    echo "$CODE_BLOCK_SHELL_LOGOUT" >> "$SHELL_LOGOUT_PATH"
else
    echo "$CODE_BLOCK_SHELL_LOGOUT" > "$SHELL_LOGOUT_PATH"
fi
echo "$CODE_BLOCK_SHELL_LOGOUT" > "$CODE_BLOCKS_DIR/$shell_profile"

# <<< Code blocks insertion <<<

# >>> Add to `PATH` >>>
# Get list of files to link
MANUAL_ARRAY=("findTraces.bash" \
              "processTraces.bash" \
              "uninstallFromFileList.bash")
for file_path in "$HERMANS_CODE_INSTALL_PATH/Shell Package/scripts/_modules/uninstaller"/*; do
    :
    file_base_name="$(basename -- "$file_path")"
    counter=0
    for array_value in "${MANUAL_ARRAY[@]}"; do
        if [[ "$file_base_name" == "$array_value" ]]; then
            counter=$((counter+1))
        else
            :
        fi
    done
    if [ "$counter" -gt 0 ]; then
        file_stem="${file_base_name%.*}"
        if [ -d "/Users/$USER/.local/bin" ]; then
            :
        else
            mkdir -p "/Users/$USER/.local/bin"
        fi
        ln -s "$file_path" "/Users/$USER/.local/bin/$file_stem"
    else
        :
    fi
done
# <<< Add to `PATH` <<<

# TODO: Set computer name. See "journal/articles/Computer Name.md"
echo "You might want to set your computer name:

sudo scutil --set "HostName" <computer-name>
"

echo "If you did not \`source\` the installation, you will have to restart your shell or run the below command:

${BLU}source ~/$shell_profile${NC}

${bld}End of installation${nrl}
"
