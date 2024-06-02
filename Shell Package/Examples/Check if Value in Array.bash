#!/usr/bin/env bash

# Check if a string value is contained in an array

MANUAL_ARRAY=("findTraces.bash" \
              "processTraces.bash")
for file_path in "$HERMANS_CODE_INSTALL_PATH/Shell Package/macOS/uninstallers"/*; do
    :
    file_base_name="$(basename -- "$file_path")"
    counter=0
    for array_value in "${MANUAL_ARRAY[@]}"; do
        if [ "$file_base_name" == "$array_value" ]; then
            counter=$((counter+1))
        else
            :
        fi
    done
    if [ "$counter" -gt 0 ]; then
        file_stem="${file_base_name%.*}"
        ln -s "$file_path" "/usr/local/$file_stem"
    else
        :
    fi
done
