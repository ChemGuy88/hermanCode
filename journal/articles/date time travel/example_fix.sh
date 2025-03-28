out_path="example_fix.text"

echo "Print time in minute:seconds" > "$out_path"
time_previous_epoc_sec=$(( 0 ))
while [ 1 -eq 1 ];
do
    time_current_min="$(date +%M)"
    time_current_sec="$(date +%S)"
    time_current_epoc_sec=$(date +%s)
    time_current_message="$time_current_min:$time_current_sec"
    echo "$time_current_message" >> "$out_path"
    if [ $(( ${time_current_min#0} % 1 )) == 0 -a $(( ${time_current_sec#0} % 30 )) == 0 ]; then
        if [ $time_current_epoc_sec -gt $time_previous_epoc_sec ]; then
            echo "Condition met" >> "$out_path"
            time_previous_min="$time_current_min"
            time_previous_sec="$time_current_sec"
            time_previous_epoc_sec=$(date +%s)
        fi
    fi
done
