out_path="example_bug.text"

echo "Print time in minute:seconds" > "$out_path"
while [[ 1 -eq 1 ]];
do
    time_current_min="$(date +%M)"
    time_current_sec="$(date +%S)"
    time_current="$time_current_min $time_current_sec"
    time_current_message="$time_current_min:$time_current_sec"
    echo "$time_current_message" >> "$out_path"
    if [[ $(( ${time_current_min#0} % 1 )) == 0 ]] && [[ $(( ${time_current_sec#0} % 30 )) == 0 ]]; then
        # echo "  yes and yes" >> "$out_path"
        if [[ "$time_current" != "$time_previous" ]]; then
            echo "Condition met" >> "$out_path"
            time_previous_min="$time_current_min"
            time_previous_sec="$time_current_sec"
            time_previous="$time_previous_min $time_previous_sec"
        fi
    fi
done
