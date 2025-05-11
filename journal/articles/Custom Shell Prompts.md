# Custom Shell Prompts

An excerpt from the login RC that contains references for creating custom shell prompts. The comments and references are moved here to provide more space in the login RC file; their thoughtful explanation can be done at a later time.

```zsh
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
else
    echo "MASH: Warning: ($LINENO): Unsupported shell."
fi
```
