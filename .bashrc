################################################################################
################################################################################
################################################################################

export BASH_SILENCE_DEPRECATION_WARNING=1

################################################################################
### Set bash history size limits ###############################################
################################################################################

export HISTSIZE=1000  # the maximum number of commands saved during your current session
export HISTFILESIZE=1000  #  The maximum number of lines contained in the history file
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

################################################################################
### Import paths to bash executables ############################################
################################################################################

### format to prepend `path1`, ..., `path3` to `PATH`:
# PATH="path1:\
# path2:\
# path3:\
# ${PATH}"

### Modify `PATH`
PATH="/Users/herman/.local/bin:\
${PATH}"
export PATH

### >>> Commented out on 9/30/2021
# /usr/local/opt/icu4c/bin:\
# /usr/local/opt/icu4c/sbin:\
# /usr/local/opt/qt/bin:\
### <<<

################################################################################
### Import paths to Python modules #############################################
################################################################################

# PYTHONPATH
# PYTHONPATH="${PYTHONPATH}:\
# path1:\
# path2:\
# path3"
# export PYTHONPATH

# MINICONDAPATH
# MINICONDAPATH="${MINICONDAPATH}:\
# path1:\
# path2:\
# path3"
# export MINICONDAPATH

################################################################################
### Custom Prompts #############################################################
################################################################################

# Reference: https://natelandau.com/my-mac-osx-bash_profile/
# Reference (colors) https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# These colors don't work on iTerm2, because they're not 256-compatible
# Reference: http://bashrcgenerator.com/

# Custom prompt (credit to https://wiki.archlinux.org/index.php/Bash/Prompt_customization)
# This works on iTerm2 and Terminal, but Terminal has to be set to "xterm-256color" under "Terminfo"
CYAN="\[$(tput setaf 4)\]"
WINERED="\[$(tput setaf 88)\]"
ATOMGREEN="\[$(tput setaf 114)\]"
RESET="\[$(tput sgr0)\]"
export PS1="\@ [\#] ${CYAN}\W${RESET}${ATOMGREEN} -->${RESET} "

################################################################################
### Custom shortcuts ###########################################################
################################################################################

alias cddis='cd ~/Documents/dis2001'
alias cdml="cd ~/Documents/ml"
alias cdpew="cd ~/Documents/pewReligion2014"
alias cdmidas="cd ~/Documents/midas"
alias midas="cd ~/Documents/midas;ipython"
alias dis='cd ~/Documents/dis2001;~/Documents/dis.sh'

################################################################################
### Custom functions ###########################################################
################################################################################

listpath () {
     awk -F\: '{
     for (i = 0; ++i <= NF;)
          print "Path", i,":", $i
     }' <<<$1
}
# listpath $PATH
# listpath $PYTHONPATH

################################################################################
### Stuff added by other programs ##############################################
################################################################################

# Enable bash-completion from homebrew
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
fi
