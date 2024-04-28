#!/usr/bin/env bash

################################################################################
### Gate-keeping ###############################################################
################################################################################

RED=$'\e[0;31m'
GRN=$'\e[0;32m'
NC=$'\e[0m'

TheWorldIsFlat=false  # Change this to `true` to gate-keep the gate keeper.
if [[ "$TheWorldIsFlat" = true ]]; then
    read -p -r "Do you want to ${RED}continue${NC} loading BASH run commands? [Y/n]: " confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        :
        echo "${GRN}Continuing${NC} to load BASH RC."
    else
        echo "${RED}Aborting${NC} the load of BASH RC."
        return
    fi
fi

# Continue sourcing file if we're logging in interactively. Otherwise, return 
# early. This is to prevent polluting the shell with un-needed output.
# This is necessary when running `scp`.
# See https://unix.stackexchange.com/a/505642/399435

if [[ $- == *i*  ]]; then
    :  # Continue reading BASH RC
    echo "Detected ${GRN}interactive${NC} mode. ${GRN}Continuing${NC} to load BASH RC."
else
    # echo "Detected ${RED}non-interactive${NC} mode. ${RED}Aborting${NC} the load of BASH RC."
    return
fi

################################################################################
### Constants: Define values ###################################################
################################################################################

export BASH_SILENCE_DEPRECATION_WARNING=1

export HISTSIZE=1000  # the maximum number of commands saved during your current session
export HISTFILESIZE=2000  #  The maximum number of lines contained in the history file
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

################################################################################
### Constants: Modify constants ################################################
################################################################################

# Modify `PATH`
PATH="$HERMAN_CODE_DIR:\
${PATH}"
export PATH

# Modify `PYTHONPATH`
# PYTHONPATH="/PATH_TO_SOMEWHERE:\
# ${PYTHONPATH}"
# export PYTHONPATH

################################################################################
### Constants: Custom Prompts ##################################################
################################################################################

# Reference: https://natelandau.com/my-mac-osx-bash_profile/
# Reference (colors) https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# These colors don't work on iTerm2, because they're not 256-compatible
# Reference: http://bashrcgenerator.com/

# Custom prompt (credit to https://wiki.archlinux.org/index.php/Bash/Prompt_customization)
# This works on iTerm2 and Terminal, but Terminal has to be set to "xterm-256color" under "Terminfo"
CYAN="\[$(tput setaf 4)\]"
ATOMGREEN="\[$(tput setaf 114)\]"
RESET="\[$(tput sgr0)\]"
if [ -z "${CONDA_DEFAULT_ENV-}" ];
then
    PROMPT_CONDA_PREFIX=""
else
    PROMPT_CONDA_PREFIX="(${CONDA_DEFAULT_ENV}) "
fi

export PS1="${PROMPT_CONDA_PREFIX}\@ [\#] ${CYAN}\W${RESET}${ATOMGREEN} -->${RESET} "

################################################################################
### Constants: Imported ########################################################
################################################################################

LIMERICKS_IN_PATH="$HERMAN_CODE_DIR/limericks_in.bash"
if [ -f "$LIMERICKS_IN_PATH" ]; then
    # shellcheck source="$HERMAN_CODE_DIR/limericks_in.bash"
    source "$LIMERICKS_IN_PATH"
fi

################################################################################
### Functions ##################################################################
################################################################################

# shellcheck source="$HERMAN_CODE_DIR/Shell Package/macOS/functions.bash"
source "$HERMAN_CODE_DIR/Shell Package/macOS/functions.bash"

################################################################################
### Shortcuts ##################################################################
################################################################################

alias vim='vi -S $HERMAN_CODE_DIR/vim/.vimrc'
cd ~ || return
pgrep -U root -f find | xargs ps

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# <<< Customizations by Herman <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
