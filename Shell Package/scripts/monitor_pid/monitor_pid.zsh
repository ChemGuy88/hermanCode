#!/bin/zsh
# Monitors a set of PIDs.

if [ -z "$HERMANS_CODE_INSTALL_PATH" ]; then
    echo "$(basename "$0"): Error: The environment variable \`HERMANS_CODE_INSTALL_PATH\` was not found. This is necessary to locate the required functions."
    return
else
    source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/functions.bash"
fi

pseudo_man() {
    # A function that mimics a `man` page.`
    cat <<USAGE
This script monitors a set of process IDs \`pid\` by calling \`ps\` with all options every five minutes.

$(basename "$ZSH_ARGZERO") -h
$(basename "$ZSH_ARGZERO") [-btv] -p pid[,pid[...]] [-f snapshot_frequency] [-o out_path]

    1st form: Get help for this function.
    2nd form: Monitor the list of comma-separated process IDs \`pid\`, and optionally write them to the specified file path \`out_path\`.
        -b  Run program in background using \`nohup\`.
        -f  The snapshot frequency, how often in seconds. Default is every 10 minutes (600 seconds).
        -o  Output file path.
        -p  List of comma-separated process IDs \`pid\`.
        -t  Run program in test mode. This does not use \`ps\`, but instead prints the PIDs to the output.
        -v  Verbose mode.
USAGE
exit 0
}

hint_help() {
    echo "$(basename "$0"): Please use the \`-h\` flag to print help on how to use the program." 1>&2
}

monitoring_loop() {
    # This is the core body of the script.
    # >>> Function arguments <<<
    command_string="$1"
    snapshot_frequency="$2"
    # <<< Function arguments <<<

    if [ -z "$HERMANS_CODE_INSTALL_PATH" ]; then
        echo "$(basename "$0"): Error: The environment variable \`HERMANS_CODE_INSTALL_PATH\` was not found. This is necessary to locate the required functions."
        return
    else
        source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/functions.bash"
    fi

    # >>> Function body >>>
    time_previous_min="$(date +%M)"
    time_previous_sec="$(date +%S)"
    time_previous_epoc_sec=$(date +%s)
    time_previous="$time_previous_min:$time_previous_sec ($time_previous_epoc_sec)"  # For debugging
    echo " >>> Snapshot Monitoring at $(getTimestamp) >>>"
    eval $command_string
    echo " <<< Snapshot Monitoring at $(getTimestamp) <<<"
    while [ 1 -eq 1 ];
    do
        time_current_min="$(date +%M)"
        time_current_sec="$(date +%S)"
        time_current_epoc_sec=$(date +%s)
        if [ "debugging" = "" ]; then
            time_current="$time_current_min:$time_current_sec ($time_current_epoc_sec)"  # For debugging
            echo "\`time_current\`: $time_current | \`time_previous\`: $time_previous"
        fi
        if [ $(( $time_current_epoc_sec % 30 )) = 0 -a $time_current_epoc_sec -gt $time_previous_epoc_sec ]; then
            echo " >>> Snapshot Monitoring at $(getTimestamp) >>>"
            eval $command_string
            echo " <<< Snapshot Monitoring at $(getTimestamp) <<<"
            time_previous_min="$time_current_min"
            time_previous_sec="$time_current_sec"
            time_previous_epoc_sec=$(date +%s)
            if [ "debugging" = "" ]; then
                time_previous="$time_current"  # For debugging
            fi
        fi
    done
    # <<< Function body <<<
}

while getopts "bf:ho:p:tv" opt; do
    case "${opt}" in
        b) bg_mode="TRUE";;
        f) snapshot_frequency="$OPTARG";;
        h) help_flag="TRUE";;
        o) out_path="$OPTARG";;
        p) pid_string_0="$pid_string_0,$OPTARG";;
        t) test_mode="TRUE";;
        v) verbose="TRUE";;
        *) usage;;
    esac
done
shift $((OPTIND -1))

# Convert comma-separated string to array
pid_string=${pid_string_0:1}
pid_array=(${(@s:,:)pid_string})

# >>> Argument validation and confirmation >>>
# Make sure exactly one form has been chosen.
if [ -z "${pid_array[*]}" ] && [ -z "$help_flag" ]; then
    echo "$(basename "$0"): Use at least one of the program forms."
    hint_help
    exit 1
elif [ "${pid_array[*]}" ] && [ "$help_flag" ]; then
    echo "$(basename "$0"): Argument validation failed. You can not use \`-p\` and \`-h\`"
    hint_help
    exit 2
fi

echo "Argument confirmation:"

# Form 1 confirmation
if [ -z "$help_flag" ]; then
    :
else
    echo "  \`help_flag\`: \"$help_flag\""
fi

# Form 2 validation and confirmation
# Argument `-p`
if [ -z "${pid_array[*]}" ]; then
    :
else
    # Validation: Assert that `pid_array` is a list of comma-separated integers.
    for pid in "${pid_array[@]}"; do
        if [[ "$pid" =~ ^[0-9]+$ ]]; then
            :
        else
            echo "Error: Process IDs must be integers. Make sure you passed a list of comma-separated process IDs (integers) with the \`-p\` option."
            exit 2
        fi
    done
    # Confirmation
    echo "  \`pid_array\`:"
    for val in "${pid_array[@]}"; do
        echo "    - $val"
    done
fi

# Argument `-b`
if [ -z "$bg_mode" ]; then
    :
else
    echo "  \`bg_mode\`: \"$bg_mode\""
fi

# Argument `-f`
if [ -z "$snapshot_frequency" ]; then
    snapshot_frequency=$(( 600 ))
else
    # Validate
    if [[ "$snapshot_frequency" =~ ^[0-9]+$ ]]; then
        :
    else
        echo "Error: The snapshot frequency must be a positive integer."
        exit 3
    fi
fi
echo "  \`snapshot_frequency\`: \"$snapshot_frequency\""

# Argument `-o`
if [ -z "$out_path" ]; then
    out_path="$PWD/monitor_pid $(getTimestamp).text"
else
    out_path="$out_path"
fi
echo "  \`out_path\`: \"$out_path\""

# Argument `-t`
if [ -z "$test_mode" ]; then
    :
else
    echo "  \`test_mode\`: \"$test_mode\""
fi
# Argument `-v`
if [ -z "$verbose" ]; then
    :
else
    echo "  \`verbose\`: \"$verbose\""
fi

# <<< Argument confirmation <<<

# >>> Form selection >>>
# Form 1
if [ "$help_flag" = "TRUE" ]; then
    pseudo_man
# Form 2
elif [ -z "$help_flag" ]; then
    echo "Monitoring pids..."
fi
# <<< Form selection <<<

# >>> Construct command string >>>
keywords_list=$(echo "$(ps -L)" | tr '\n' ' ')
keywords_array=(${(@s: :)keywords_list})

if [ "$verbose" = "TRUE" ]; then
    echo "\`keywords_list\`:
        \"$keywords_list\""
fi

command_string_0="ps"

# Add options to command string
for keyword in "${keywords_array[@]}"; do
   command_string_0="$command_string_0 -o $keyword"
done

if [ "$verbose" = "TRUE" ]; then
    echo "\`command_string_0\`:
        \"$command_string_0\""
fi

# Add PID[s] to command strings
command_string_0="$command_string_0 -p $pid_string"

if [ "$verbose" = "TRUE" ]; then
    echo "\`command_string_0\`:
        \"$command_string_0\""
fi

# Use test mode or not
if [ "$test_mode" = "TRUE" ]; then
    command_string="echo \"This is a test message for process IDs $pid_string\""
else
    command_string="$command_string_0"
fi
# <<< Construct command string <<<

# Execute command string
echo "Monitoring process IDs $pid_string"
if [ "$bg_mode" = "TRUE" ]; then
    temp_path_monitoring_loop="$HERMANS_CODE_INSTALL_PATH/temp/monitoring_loop.zsh"
    mkdir -p "$(dirname "$temp_path_monitoring_loop")"
    export -f monitoring_loop > "$temp_path_monitoring_loop"
    echo "" >> "$temp_path_monitoring_loop"
    echo "monitoring_loop '$command_string' '$snapshot_frequency'" >> "$temp_path_monitoring_loop"
    nohup zsh "$temp_path_monitoring_loop" &> "$out_path" &
else
    monitoring_loop "$command_string" "$snapshot_frequency"
fi
