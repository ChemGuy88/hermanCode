#!/bin/bash
# Time-to-completion tables
# n        | Time (h:mm:ss) | System
# 100000   | 0:01:03        | PySpark
# 100000   | 0:00:02        | PySpark
# 10000000 | 0:04:33        | PySpark
# 10000001 | 0:07:55        | PySpark
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
