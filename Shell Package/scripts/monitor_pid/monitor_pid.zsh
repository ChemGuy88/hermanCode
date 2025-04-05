#!/usr/bin/env zsh
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
This script monitors a set of process IDs \`pid\` by periodically calling \`ps\` with all options.

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
        if [ $(( $time_current_epoc_sec % $snapshot_frequency )) = 0 -a $time_current_epoc_sec -gt $time_previous_epoc_sec ]; then
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

# Store monitoring parameters
message="Argument confirmation:"
echo "$message"
monitoring_parameters="$message"  # Initialize `monitoring_parameters`

# Form 1 confirmation
if [ -z "$help_flag" ]; then
    :
else
    message="  \`help_flag\`: \"$help_flag\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
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
    message_1="  \`pid_array\`:"
    for val in "${pid_array[@]}"; do
        message_2="    - $val"
        message_1="$message_1\n$message_2"
    done
    echo "$message_1"
    monitoring_parameters="$monitoring_parameters\n$message_1"
    unset message_1
    unset message_2
fi

# Argument `-b`
if [ -z "$bg_mode" ]; then
    :
else
    message="  \`bg_mode\`: \"$bg_mode\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
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
message="  \`snapshot_frequency\`: \"$snapshot_frequency\""
echo "$message"
monitoring_parameters="$monitoring_parameters\n$message"
unset message

# Argument `-o`
if [ -z "$out_path" ]; then
    out_path="$PWD/monitor_pid $(getTimestamp).text"
else
    out_path="$out_path"
fi
message="  \`out_path\`: \"$out_path\""
echo "$message"
monitoring_parameters="$monitoring_parameters\n$message"
unset message

# Argument `-t`
if [ -z "$test_mode" ]; then
    :
else
    message="  \`test_mode\`: \"$test_mode\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
fi
# Argument `-v`
if [ -z "$verbose" ]; then
    :
else
    message="  \`verbose\`: \"$verbose\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
fi

# <<< Argument confirmation <<<

# >>> Form selection >>>
# Form 1
if [ "$help_flag" = "TRUE" ]; then
    pseudo_man
# Form 2
elif [ -z "$help_flag" ]; then
    message="Preparing for monitoring process."
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
fi
# <<< Form selection <<<

# >>> Construct command string >>>
keywords_list=$(echo "$(ps -L)" | tr '\n' ' ')
keywords_array=(${(@s: :)keywords_list})

if [ "$verbose" = "TRUE" ]; then
    message="\`keywords_list\`:
        \"$keywords_list\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
fi

command_string_1="ps -f"  # The `-f` flag allows us to bypass the terminal width limit, and extends the output length to about 60,000 characters. See `man ps` for details.

# Add options to command string
# We first append fields that do not contain spaces.
# We then append the `lstat` field which contains a known amount of spaces
# We finally add only one of `command` or `args`, since they are equivalent and have an unknown number of spaces.
num_keywords_used=0
for keyword in "${keywords_array[@]}"; do
    if [[ ! "$keyword" =~ "lstart|args|comm" ]]; then
        command_string_1="$command_string_1 -o $keyword"
        num_keywords_used=$(($num_keywords_used + 1))
    fi
done
for keyword in "${keywords_array[@]}"; do
    if [[ "$keyword" =~ "lstart" ]]; then
        command_string_1="$command_string_1 -o $keyword"
        num_keywords_used=$(($num_keywords_used + 1))
    fi
done
for keyword in "${keywords_array[@]}"; do
    if [[ "$keyword" =~ "command|args" ]]; then
        command_string_1="$command_string_1 -o $keyword"
        num_keywords_used=$(($num_keywords_used + 1))
        break
    fi
done

if [ "$verbose" = "TRUE" ]; then
    message="\`num_keywords_used\`: \"$num_keywords_used\"
\`command_string_1\`:
    \"$command_string_1\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
fi

# Add PID[s] to command strings
command_string_2="$command_string_1 -p $pid_string"

if [ "$verbose" = "TRUE" ]; then
    message="\`command_string_2\`:
    \"$command_string_2\""
    echo "$message"
    monitoring_parameters="$monitoring_parameters\n$message"
    unset message
fi

# Use test mode or not
if [ "$test_mode" = "TRUE" ]; then
    command_string="echo \"This is a test message for process IDs $pid_string\""
else
    command_string="$command_string_2"
fi
# <<< Construct command string <<<

# Execute command string
message="Beginning monitoring process.
 >>> Monitoring Parameters >>>
num_keywords_used=$num_keywords_used
 <<< Monitoring Parameters <<<"
echo "$message"
monitoring_parameters="$monitoring_parameters\n$message"
unset message
if [ "$bg_mode" = "TRUE" ]; then
    temp_path_monitoring_loop="$HERMANS_CODE_INSTALL_PATH/temp/monitoring_loop.zsh"
    mkdir -p "$(dirname "$temp_path_monitoring_loop")"
    export -f monitoring_loop > "$temp_path_monitoring_loop"
    echo "" >> "$temp_path_monitoring_loop"
    echo "monitoring_loop '$command_string' '$snapshot_frequency'" >> "$temp_path_monitoring_loop"
    # Initialize file `out_path` with monitoring parameters
    echo "$monitoring_parameters" > "$out_path"
    # Execute monitor
    nohup zsh "$temp_path_monitoring_loop" &>> "$out_path" &
else
    monitoring_loop "$command_string" "$snapshot_frequency"
fi
