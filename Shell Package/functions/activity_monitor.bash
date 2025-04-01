#!/usr/bin/env bash

usage0() {
    cat <<USAGE
Get activity statistics for a process (\`pid\`) or process group (\`pgip\`).

activity_monitor.bash [-g grp[,grp...]]
                      [-p pid[,pid...]]

    -g The list of process group IDs.
    -p The list of process IDs.
USAGE
}
usage() {
    usage0 1>&2
    echo "Error code $1"
    exit "$1"
}

while getopts ":g:p:" opt; do
    case "${opt}" in
        g) list_of_grp+=("$OPTARG");;
        p) list_of_pid+=("$OPTARG");;
        *) usage 1;;
    esac
done
shift $((OPTIND -1))

# >>> Argument confirmation >>>
SHOULD_EXIT=0

if [[ "${list_of_grp[*]}" ]] && [[ "${list_of_pid[*]}" ]]; then
    SHOULD_EXIT=$((SHOULD_EXIT+1))
    usage 2
elif [[ -z "${list_of_grp[*]}" ]] && [[ -z "${list_of_pid[*]}" ]]; then
    SHOULD_EXIT=$((SHOULD_EXIT+1))
    usage 3
fi

# `list_of_grp`
if [[ "${list_of_grp[*]}" ]]; then
    echo "The first value of the argument array 'list_of_grp' is '$list_of_grp'"
    echo "The whole list of values is '${list_of_grp[*]}'"

    echo "Or:"

    for val in "${list_of_grp[@]}"; do
        echo " - $val"
    done
fi

# `list_of_pid`
if [[ "${list_of_pid[*]}" ]]; then
    echo "The first value of the argument array 'list_of_pid' is '$list_of_pid'"
    echo "The whole list of values is '${list_of_pid[*]}'"

    echo "Or:"

    for val in "${list_of_pid[@]}"; do
        echo " - $val"
    done
fi

# Decide to exit
if [ "$SHOULD_EXIT" -eq 0 ]; then
    :
else
    usage 4
fi
# <<< Argument confirmation <<<

if [[ "${list_of_grp[*]}" ]]; then
    ps -o pid,pgid,ppid,rss,vsz,%cpu,%mem,state,lstart,command -g "$list_of_grp"
elif [[ "${list_of_pid[*]}" ]]; then
    ps -o pid,pgid,ppid,rss,vsz,%cpu,%mem,state,lstart,command -p "$list_of_pid"
fi
