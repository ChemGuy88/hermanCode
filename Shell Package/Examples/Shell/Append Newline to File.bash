#!/usr/bin/env bash

# An example of how to append a newline to a file. This is relevant because a 
# file is defined as ending with an empty line, and a line, in turn is 
# defined as a string of text ending with a newline.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

FILE_PATH_1="Shell Package/macOS/Examples/Data/File with Final Newline.txt"
FILE_PATH_2="Shell Package/macOS/Examples/Data/File with No Final Newline.txt"

FILE_PATH_ARRAY=("$FILE_PATH_1" "$FILE_PATH_2")

for FILE_PATH in "${FILE_PATH_ARRAY[@]}";
do
    echo "${bld}Processing \"$(basename "$FILE_PATH")\"${nrl}:"
    # Preview data for processing
    echo "   ${bld}${GRN}>>>${nrl}${NC} This is the text before processing ${bld}${GRN}>>>${nrl}${NC}"
    cat "$FILE_PATH"
    echo "   ${bld}${GRN}<<<${nrl}${NC} This is the text before processing  ${bld}${GRN}<<<${nrl}${NC}"

    # Process data
    FILE_PATH_RESULT="Append Newline to File - Example Result.txt"
    sed -e '$ a \ '$'\n' "$FILE_PATH" > "$FILE_PATH_RESULT"

    # Print results
    echo "   ${bld}${RED}>>>${nrl}${NC} This is the text after processing ${bld}${RED}>>>${nrl}${NC}"
    cat "$FILE_PATH_RESULT"
    echo "   ${bld}${RED}<<<${nrl}${NC} This is the text after processing  ${bld}${RED}<<<${nrl}${NC}"
    echo ""
done
