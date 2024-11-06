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
        exit 1
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
if [[ "$SHELL" = "/bin/zsh" ]]; then
    this_file_path="${(%):-%N}"  # ZSH syntax
    HERMANS_CODE_SHELL_PKG_PATH="$(dirname "$this_file_path")"
elif [[ "$SHELL" = "/bin/bash" ]]; then
    HERMANS_CODE_SHELL_PKG_PATH="${BASH_SOURCE[0]%/*}"
fi

HERMANS_CODE_INSTALL_PATH="$(dirname "$HERMANS_CODE_SHELL_PKG_PATH")"

export HERMANS_CODE_INSTALL_PATH

# BASH configurations
export HISTFILESIZE=2000  #  The maximum number of lines contained in the history file

# OS-specific values
if [[ $OSTYPE == "darwin"* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    if [[ "$(hostname)" =~ ("herman-imac.attlocal.net"|"herman-imac.local") ]]; then
        # :: macOS at home ::
        MIDAS_INSTALL_PATH="/Users/herman/Documents/midas"
        export MIDAS_INSTALL_PATH
    fi
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
    if [[ "$(hostname)" =~ ("herman-imac.attlocal.net"|"herman-imac.local") ]]; then
        # :: macOS at home ::
        PYTHONPATH_ADDENDUM_1="/Users/herman/Documents/midas/src"  # Add project "midas" to `PATH`
        PYTHONPATH_ADDENDUM_2="$HERMANS_CODE_INSTALL_PATH/Python Package/src"  # Add project "Herman's Code (Python Package)" to `PATH`
        export PYTHONPATH="$PYTHONPATH:\
$PYTHONPATH_ADDENDUM_1:\
$PYTHONPATH_ADDENDUM_2"
    elif [[ "$(hostname)" =~ ("Hermans-MacBook-Air.local") ]]; then
        # :: macOS on MBA ::
        PATH_ADDENDUM_1="/Users/$USER/.local/bin"  # Custom user scripts
        PATH_ADDENDUM_2="/Library/PostgreSQL/17/bin"  # postgresql command-line utility
        export PATH="$PATH:\
$PATH_ADDENDUM_1:\
$PATH_ADDENDUM_2"
    elif [[ "$(hostname)" =~ ("Hermans-MacBook-Pro.local") ]]; then
        # :: macOS on MBA ::
        PATH_ADDENDUM_1="/Users/$USER/.local/bin"  # Custom user scripts
        export PATH="$PATH:\
$PATH_ADDENDUM_1"
    fi
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # :: Linux ::
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

if [[ "$SHELL" = "/bin/zsh" ]]; then
    # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
    # ASCII color digits: https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
    custom_prompt="$PROMPT_CONDA_PREFIX%F{cyan}%t%f [%F{magenta}%i%f] %F{9}%1d%f %F{green}%B-->%f%b "  # builtins
    export PROMPT="$custom_prompt"
elif [[ "$SHELL" = "/bin/bash" ]]; then
    # Assumes we have set the Atom One Dark profile on Terminal
    # See https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
    GREEN="\e[0;32m"
    CYAN="\e[0;36m"
    RESET="\e[0;38m"
    # Using `tput`
    CYAN="\[$(tput setaf 4)\]"
    ATOMGREEN="\[$(tput setaf 114)\]"
    RESET="\[$(tput sgr0)\]"
    custom_prompt="$PROMPT_CONDA_PREFIX\@ [\#] ${CYAN}\W${RESET}${ATOMGREEN} -->${RESET} "
    export PS1="$custom_prompt"
fi


################################################################################
################################################## Constants: Custom Prompts ###
################################################################################

################################################################################
### Constants: Imported ########################################################
################################################################################

LIMERICKS_IN_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_in.sh"
if [ -f "$LIMERICKS_IN_PATH" ]; then
    # shellcheck source="Shell Package/limericks_in.sh"
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

alias vim='vi -S "$HERMANS_CODE_INSTALL_PATH/Shell Package/vim/.vimrc"'

# Machine-Specific conveniences
if [[ $OSTYPE == "darwin"* ]]; then
    # :: macOS ::
    getPgrep herman python
    alias lss="ls -lash"
    if [[ "$(hostname)" =~ ("herman-imac.attlocal.net"|"herman-imac.local") ]]; then
        # :: macOS at home ::
        eval "$(/usr/local/bin/brew shellenv)"  # Formerly in ".bash_profile"
        # :: >>> macOS at home - Midas project >>> ::
        cd ~/"Documents/midas" || exit 1
        conda activate midas
        source "$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_in_midas.sh"
        # :: <<< macOS at home - Midas project <<< ::
    elif [[ "$(hostname)" =~ ("Hermans-Air.attlocal.net"|"Hermans-MacBook-Air.local") ]]; then
        # :: macOS on MBA ::
        eval "$(/opt/homebrew/bin/brew shellenv)"  # Add brew to PATH.
        # :: >>> macOS on MBA - Meta Interview >>> ::
        if [[ 1 = 2 ]]; then
            cd ~/"Documents/Meta Interview/Preparation Hub" || exit 1
            conda activate herman-base
        fi
        # :: <<< macOS on MBA - Meta Interview <<< ::
        # :: >>> macOS on MBA - Amazon Web Services >>> ::
        if [[ 1 = 1 ]]; then
            cd "/Users/herman/Documents/AWS Certification/02 - AWS Technical Essentials Part 1" || exit 1
            conda activate herman-awstut
            source "$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_in_aws.sh"
        fi
        # :: <<< macOS on MBA - Amazon Web Services <<< ::
        # :: >>> macOS on MBA - LeetCode >>> ::
        if [[ 1 = 2 ]]; then
            cd ~/"Documents/LeetCode" || exit 1
            conda activate herman-leetcode
        fi
        # :: <<< macOS on MBA - LeetCode <<< ::
    else
        echo "Unsupported machine."
    fi
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # :: Linux ::
    alias lss="ls -lashX"
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
