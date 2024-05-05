#!/bin/bash

# shellcheck source="Shell Package/functions/functions.bash"
source "Shell Package/functions/functions.bash"

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

usage0() {
    cat <<USAGE
This processes the results from \`findTraces.bash\` by doing the following:

    1. Removing the leading text \"/System/Volumes/Data\".
    2. Removing duplicates.
    3. Removing lines starting with the leading text passed as \`<LEADING_TEXT>\`.
    4. Sorts the results.

$0 -f <FILE_PATH> -l [<LEADING_TEXT>] -t TRUE|FALSE

    -f The path to the file that contains the traces.
    -t The script test flag. One of TRUE or FALSE.
USAGE
}

usage() {
    usage0 1>&2
    exit 1
}


# >>> Argument parsing >>>
LEADING_TEXT_DEFAULT=("/private/var/db")  # These files cannot be deleted per https://discussions.apple.com/thread/252345091
while getopts ":f:l:t:" opt; do
    case "${opt}" in
        f) FILE_PATH=${OPTARG};;
        l) LEADING_TEXT+=("$OPTARG");;
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
    echo "${RED}Note${NC}: You must supply the path to the file."
    SHOULD_EXIT=1
fi
if [ -f "$FILE_PATH" ]; then
    :
else
    echo "${RED}Note${NC}: The file provided does not exist."
    SHOULD_EXIT=1
fi

# $LEADING_TEXT
# If leading text is empty, set to default.
if [ -z "${LEADING_TEXT[*]}" ]; then
    for EL in "${LEADING_TEXT_DEFAULT[@]}"
    do
        LEADING_TEXT+=("$EL")
    done
    else
        :
fi

# $TEST_MODE
MESSAGE="${RED}Note${NC}: TEST_MODE must be one of {TRUE, FALSE}."
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
echo "LEADING_TEXT:"
for val in "${LEADING_TEXT[@]}"; do
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

# Step 3: Remove lines that start with leading text
echo "  Removing lines starting with leading text..."
it3=1
FILE_PATH_TEMP4_0="$FILE_PATH_TEMP3"
FILE_PATH_TEMP4_1="$FILE_PATH_TO.tmp$it3"
for text0 in "${LEADING_TEXT[@]}";
do
    text="$(echo "$text0" | sed 's/\//\\\//g')"  # escape path separators
    sed "/^'$text'/d" "$FILE_PATH_TEMP4_0" > "$FILE_PATH_TEMP4_1"
    it3=$((it3+1))
    FILE_PATH_TEMP4_0="$FILE_PATH_TEMP4_1"
    FILE_PATH_TEMP4_1="$FILE_PATH_TO.tmp$it3"
done
FILE_PATH_TEMP4="$FILE_PATH_TO.tmp4"
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
