_hatch_completion() {
    local IFS=$'\n'
    local response

    response=$(env COMP_WORDS="${COMP_WORDS[*]}" COMP_CWORD=$COMP_CWORD _HATCH_COMPLETE=bash_complete $1)

    for completion in $response; do
        IFS=',' read type value <<< "$completion"

        if [[ $type == 'dir' ]]; then
            COMPREPLY=()
            compopt -o dirnames
        elif [[ $type == 'file' ]]; then
            COMPREPLY=()
            compopt -o default
        elif [[ $type == 'plain' ]]; then
            COMPREPLY+=($value)
        fi
    done

    return 0
}

_hatch_completion_setup() {
    bash_version=$(bash --version | grep -Eo "[[:digit:]]{1}\.[[:digit:]]{1}")
    bash_version_match="$(bc -e "$bash_version >= 4.4")"
    if [[ "$bash_version_match" = 1 ]]; then
        complete -o nosort -F _hatch_completion hatch
    else
        complete -F _hatch_completion hatch
    fi
}

_hatch_completion_setup;
