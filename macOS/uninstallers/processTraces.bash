#!/bin/bash

# shellcheck source="/Users/herman/.hermanCode/macOS/functions.bash"
source "/Users/herman/.hermanCode/macOS/functions.bash"

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

usage0() {
    cat <<USAGE

    $0 -f <FILE_PATH> -t TRUE|FALSE
    -f The path to the file that contains the traces.
    -t The script test flag. One of TRUE or FALSE.
USAGE
}

usage() {
    usage0 1>&2
    exit 1
}


# >>> Argument parsing >>>
while getopts ":f:t:" opt; do
    case "${opt}" in
        f) FILE_PATH=${OPTARG};;
        t) TEST_MODE=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

if [ -z "${FILE_PATH[*]}" ] || [ -z "${TEST_MODE}" ]; then
    usage
fi
# <<< Argument parsing <<<

# >>> Argument confirmation >>>
SHOULD_EXIT=0

# $FILE_PATH
if [[ -z "$FILE_PATH" ]]; then
    echo "${RED}You must supply the path to the file${NC}."
    SHOULD_EXIT=1
fi

# $TEST_MODE
MESSAGE="${RED}TEST_MODE must be one of {TRUE, FALSE}${NC}."
if [ -z "$TEST_MODE" ]; then
    echo "$MESSAGE"
    SHOULD_EXIT=1
else
    if [ "$TEST_MODE" == "TRUE" ] || [ "$TEST_MODE" == "FALSE" ]; then
        :
    else
        echo "$MESSAGE"
        SHOULD_EXIT=1
    fi
fi

# Argument confirmation
echo "FILE_PATH:"
for val in "${FILE_PATH[@]}"; do
    echo "  - \"${GRN}$val${NC}\""
done
echo "TEST_MODE = ${GRN}${TEST_MODE}${NC}"

if [ "$SHOULD_EXIT" -eq 0 ]; then
    :
else
    exit $SHOULD_EXIT
fi
# <<< Argument confirmation <<<

# Make output directory
FIND_TRACES_DIRECTORY="$(dirname  "$FILE_PATH")/Processed"
if ! [ -d "$FIND_TRACES_DIRECTORY" ]; then
    if [ "$TEST_MODE" == "FALSE" ]; then
        mkdir -p "$FIND_TRACES_DIRECTORY"
    else
        :
    fi
    echo "Made directory at $FIND_TRACES_DIRECTORY"
elif [ -d "$FIND_TRACES_DIRECTORY" ]; then
    echo "Directory already exists: \"$FIND_TRACES_DIRECTORY\""
fi

# Make sure file ends with a newline
FILE_PATH_BASENAME="$(basename "$FILE_PATH")"
FILE_PATH_TO="$FIND_TRACES_DIRECTORY/$FILE_PATH_BASENAME"
FILE_PATH_TEMP1="$FILE_PATH_TO.tmp1"
sed -e '$ a \ '$'\n' "$FILE_PATH" > "$FILE_PATH_TEMP1"

# Preview data to be processed
if [ "$TEST_MODE" == TRUE ]; then
    echo " ${bold}${GRN}>>>${normal}${NC} This is the text being fed to the for loop ${bold}${GRN}>>>${normal}${NC}"
    cat "$FILE_PATH_TEMP1"
    echo " ${bold}${GRN}<<<${normal}${NC} This is the text being fed to the for loop ${bold}${GRN}<<<${normal}${NC}"
fi

# Preview data line by line
if [ "$TEST_MODE" == TRUE ]; then
    echo " ${bold}${BLU}>>>${normal}${NC} Segmentation of the text ${bold}${BLU}>>>${normal}${NC}"
    it1=0
    while read -r line
    do
        it1=$((it1+1))
        echo "  Line $it1: \"$line\""
    done < "$FILE_PATH_TEMP1"
    echo " ${bold}${BLU}<<<${normal}${NC} Segmentation of the text ${bold}${BLU}<<<${normal}${NC}"
fi

# >>> Main body of processing code >>>
echo "Processing traces in \"$FILE_PATH\"."

# Step 1: Remove leading text, "/System/Volumes/Data"
echo "  Removing leading text, \"/System/Volumes/Data\""
FILE_PATH_TEMP2="$FILE_PATH_TO.tmp2"
if [ -f "$FILE_PATH_TEMP2" ]; then
    rm "$FILE_PATH_TEMP2"
else
    :
fi
it2=0
while read -r line
do
    it2=$((it2+1))
    # If line starts with "/System/Volumes/Data", remove text
    if [[ "$line" == /System/Volumes/Data* ]]; then
        newLine="$(echo "$line" | sed 's/\/System\/Volumes\/Data//')"
        A="${RED}↳${NC}"
    else
        newLine="$line"
        A="↳"
    fi
    if [ "$TEST_MODE" == TRUE ]; then
        echo "  Line $it2 (↱): \"$line\""
        echo "  Line $it2 ($A): \"$newLine\""
    fi
    echo "$newLine" >> "$FILE_PATH_TEMP2"
done < <(grep -v -e '^#' -e '^$' "$FILE_PATH_TEMP1")

# Step 2: Remove duplicates
echo "  Removing duplicates..."
FILE_PATH_TEMP3="$FILE_PATH_TO.tmp3"
awk '!seen[$0]++' "$FILE_PATH_TEMP2" > "$FILE_PATH_TEMP3"

# Step 3: Remove lines that start with leading text, "/Volumes/BOOTCAMP"
echo "  Removing lines starting with \"/Volumes/BOOTCAMP\"..."
FILE_PATH_TEMP4="$FILE_PATH_TO.temp4"
sed '/^\/Volumes\/BOOTCAMP/d' "$FILE_PATH_TEMP3" > "$FILE_PATH_TEMP4"

# Step 4: Sort final result
echo "  Sorting final results..."
sort "$FILE_PATH_TEMP4" > "$FILE_PATH_TO"

echo "Processing traces in \"$FILE_PATH\" - done."
# <<< Main body of processing code <<<

# Remove temp files
echo "Removing temporary files"
LIST_OF_TEMP_FILES=("$FILE_PATH_TEMP1" \
                    "$FILE_PATH_TEMP2" \
                    "$FILE_PATH_TEMP3" \
                    "$FILE_PATH_TEMP4")
for fpath in "${LIST_OF_TEMP_FILES[@]}"
do
    rm "$fpath"
done

echo "Removing temporary files - done."
