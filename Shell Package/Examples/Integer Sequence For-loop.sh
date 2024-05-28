#!/bin/bash

# Example for-loop. In this case, we're iterating over a sequence of
# integers from 1 to `N`, where `N` is the input`

# shellcheck source="Shell Package/functions/functions.bash"
source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/functions.bash"

timestamp=$(getTimestamp)
fpath="$timestamp.txt"
echo "$(getTimestamp) - Starting script with \`N\` = $1." | tee "$fpath"

for it in $(seq "$1");
do
   echo "$it" >> "$fpath"
done
echo "$(getTimestamp) - Script finished." | tee -a "$fpath" "$timestamp - done.txt"
