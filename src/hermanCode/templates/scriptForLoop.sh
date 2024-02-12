#!/bin/bash
timeStamp() {
	date "+%Y-%m-%d %H-%M-%S"
}
timestamp="$(timeStamp)"
fpath="$timestamp.txt"
echo "$(timeStamp) - Starting script with n = $1." > "$fpath"

for n in $(seq $1);
do
   echo $n >> "$fpath"
done
echo "$(timeStamp) - Script finished." | tee -a "$fpath" "$timestamp - done.txt"
