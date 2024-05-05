# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>> Gate-keeping >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Gate-keeping <<<
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

################################################################################
### Constants: Define values ###################################################
################################################################################

if [[ $OSTYPE == "darwin"* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    :
else
    echo "Unsupported operating system."
    exit 1
fi

export HISTFILESIZE=2000  #  The maximum number of lines contained in the history file

################################################################################
################################################### Constants: Define values ###
################################################################################

################################################################################
### Constants: Modify constants ################################################
################################################################################

# Modify `PATH`
PATH="$HERMAN_CODE_DIR:\
${PATH}"
export PATH

################################################################################
################################################ Constants: Modify constants ###
################################################################################

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
echo "$PROMPT_CONDA_PREFIX"

export PS1="${PROMPT_CONDA_PREFIX}\@ [\#] ${CYAN}\W${RESET}${ATOMGREEN} -->${RESET} "

################################################################################
################################################## Constants: Custom Prompts ###
################################################################################

################################################################################
### Constants: Imported ########################################################
################################################################################

LIMERICKS_IN_PATH="Shell Package/limericks_in.bash"
if [ -f "$LIMERICKS_IN_PATH" ]; then
    # shellcheck source="Shell Package/limericks_in.bash"
    source "$LIMERICKS_IN_PATH"
fi

################################################################################
######################################################## Constants: Imported ###
################################################################################

################################################################################
### Functions ##################################################################
################################################################################

# shellcheck source="Shell Package/functions/functions.bash"
source "Shell Package/functions/functions.bash"
source "Shell Package/functions/getIP.bash"
source "Shell Package/functions/getPgrep.bash"

################################################################################
################################################################## Functions ###
################################################################################

################################################################################
### Conveniences ###############################################################
################################################################################

alias vim='vi -S "Shell Package/vim/.vimrc"'

# OS-Specific conveniences
if [[ $OSTYPE == "darwin"* ]]; then
    # macOS
    getPgrep root find
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # Linux
    conda activate idr-bian
    getPgrep herman .
    echo
    df -h /data/herman/Projects
    echo
    du -sh /data/herman/Projects
    cd "/data/herman/Projects" || return
else
    echo "Unsupported operating system."
    exit 1
fi


################################################################################
############################################################### Conveniences ###
################################################################################
