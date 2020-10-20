################################################################################
### Set bash history size limits ###############################################
################################################################################

export HISTSIZE=1000 # the maximum number of commands saved during your current session
export HISTFILESIZE=1000 #  The maximum number of lines contained in the history file
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

################################################################################
### Import paths to bash executables ############################################
################################################################################

# format:
# PATH = "path1:path2:path3:${PATH}" # # prepends path1, ... path3 to PATH
PATH="/usr/local/Cellar/graphviz/2.40.1/bin:\
/usr/local/opt/icu4c/bin:\
/usr/local/opt/icu4c/sbin:\
/usr/local/opt/qt/bin:\
$HOME:\
$HOME/Documents:\
$HOME/Library/Python/2.7/bin:\
$HOME/Library/Python/3.7/bin:\
$HOME/Users/herman/libQGLViewer-2.7.2:\
${PATH}"
export PATH

################################################################################
### Import paths to Python modules #############################################
################################################################################

# You can also edit c.InteractiveShellApp.exec_lines in ipython_config.py.
# format:
# PYTHONPATH = "${PYTHONPATH}:path1:path2:path3" # appends path1, ... path3 to PYTHONPATH
PYTHONPATH="\
$HOME/Documents:\
$HOME/Documents/6001x:\
$HOME/Documents/6002x:\
$HOME/Documents/aml/PythonFunctions:\
$HOME/Documents/dis_genomics:\
$HOME/Documents/dspython/hw:\
$HOME/Documents/funbusta:\
$HOME/Documents/hds:\
$HOME/Documents/jzhang/cpi:\
$HOME/Documents/jzhang/synbed:\
$HOME/Documents/rankmapper:\
$HOME/Documents/vkMateFinder:\
$HOME/gpe:\
$HOME/matrix:\
$HOME/okc:\
${PYTHONPATH}"
export PYTHONPATH

MINICONDAPATH="\
/usr/local/Caskroom/miniconda/base/lib/python37.zip:\
/usr/local/Caskroom/miniconda/base/lib/python3.7:\
/usr/local/Caskroom/miniconda/base/lib/python3.7/lib-dynload:\
$HOME/.local/lib/python3.7/site-packages:\
/usr/local/Caskroom/miniconda/base/lib/python3.7/site-packages"
export MINICONDAPATH

# PYTHONPATH="${PYTHONPATH}:${MINICONDAPATH}"

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
export PS1="\@ [\#] ${CYAN}\w${RESET}${ATOMGREEN} -->${RESET} "

################################################################################
### Custom shortcuts ###########################################################
################################################################################

alias cddis='cd ~/Documents/dis2001'
alias cdfun='cd ~/Documents/funbusta'
alias cdwhyStats='cd ~/Documents/whyStats/'
alias dis='cd ~/Documents/dis2001;~/Documents/dis.sh'
alias cdepistats='cd ~/Documents/epistats'
alias cdkagrader='cd ~/Documents/kaGrader'
alias cdinstacon='cd ~/Documents/instacon'

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Herman/Documents/google-cloud-sdk/path.bash.inc' ]; then source '/Users/Herman/Documents/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Herman/Documents/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/Herman/Documents/google-cloud-sdk/completion.bash.inc'; fi

# Enable bash-completion from homebrew
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
