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

# Package paths
HERMANS_CODE_SHELL_PKG_PATH="${BASH_SOURCE[0]%/*}"
HERMANS_CODE_INSTALL_PATH="$(dirname "$HERMANS_CODE_SHELL_PKG_PATH")"

export HERMANS_CODE_INSTALL_PATH

# BASH configurations
export HISTFILESIZE=2000  #  The maximum number of lines contained in the history file

# OS-specific values
if [[ $OSTYPE == "darwin"* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    :
else
    echo "Unsupported operating system." || exit 1
fi

################################################################################
################################################### Constants: Define values ###
################################################################################

################################################################################
### Constants: Modify values ###################################################
################################################################################

if [[ $OSTYPE == "darwin"* ]]; then
    :
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    PATH_ADDENDUM_1="/opt/mssql-tools18/bin"  # Add `sqlcmd` to `PATH`
    export PATH="$PATH:\
$PATH_ADDENDUM_1"
else
    echo "Unsupported operating system."
    return
fi

################################################################################
################################################### Constants: Modify values ###
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

LIMERICKS_IN_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_in.bash"
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
source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/functions.bash"
source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/getIP.bash"
source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/getPgrep.bash"

################################################################################
################################################################## Functions ###
################################################################################

################################################################################
### Conveniences ###############################################################
################################################################################

alias vim='vi -S "$HERMANS_CODE_SHELL_PKG_PATH/Shell Package/vim/.vimrc"'

# Machine-Specific conveniences
if [[ $OSTYPE == "darwin"* ]]; then
    # :: macOS ::
    getPgrep root find
    alias ls="ls -lash"
    if [[ "herman-imac.attlocal.net" == "$(hostname)" ]]; then
        # :: macOS at home ::
        eval "$(/usr/local/bin/brew shellenv)"  # Formerly in ".bash_profile"
        # :: >>> macOS at home - Midas project >>> ::
        cd ~/"Documents/midas" || exit 1
        conda activate midas
        source "$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_in_midas.bash"
        # :: <<< macOS at home - Midas project <<< ::
    elif [[ "AHC-Mac-Admins-MacBook-Pro.local" == "$(hostname)" ]]; then
        # :: macOS at work ::
        # Run commands for the Dreambooth project
        source "$HERMANS_CODE_INSTALL_PATH/Shell Package/dreambooth.bash"
    else
        echo "Unsupported machine."
    fi
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # :: Linux ::
    alias ls="ls -lashX"
    conda activate idr-bian
    getPgrep herman .
    echo
    df -h /data/herman/Projects
    echo
    du -sh /data/herman/Projects
    cd "/data/herman/Documents/Git Repositories/Herman Code" || return
    cd "/data/herman/Mounted Drives/UF Health Shared Drive/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Xu/IRB202202722" || return
else
    echo "Unsupported machine."
    return
fi


################################################################################
############################################################### Conveniences ###
################################################################################
