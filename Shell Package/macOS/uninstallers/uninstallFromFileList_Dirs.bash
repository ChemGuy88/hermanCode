#!/bin/bash
# shellcheck disable=SC2320

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

usage0() {
    cat <<USAGE
Force deletes directories, even if not empty.
    $0 -f <FILE_PATH> -t TRUE|FALSE -o <OUT_PATH>
    -f The file path that contains the list of files and directories to delete.
    -o The file path for the output file.
    -t The script test flag. One of TRUE or FALSE.
USAGE
}

usage() {
    usage0 1>&2
    exit 1
}

# >>> Argument parsing >>>
OUT_PATH_DEFAULT="UndeletedFiles.txt"
while getopts ":f:o:t:" opt; do
    case "${opt}" in
        f) FILE_PATH+=("$OPTARG");;
        o) OUT_PATH=${OPTARG};;
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
if [[ -z "${FILE_PATH[*]}" ]]; then
    echo "${RED}You must supply a file path${NC}."
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

# $OUT_PATH
if [ -z "$OUT_PATH" ]; then
    OUT_PATH="$OUT_PATH_DEFAULT"
fi

# Argument confirmation
echo "FILE_PATH = ${FILE_PATH}"
echo "TEST_MODE = ${TEST_MODE}"
echo "OUT_PATH = ${OUT_PATH}"

if [ "$SHOULD_EXIT" -eq 0 ]; then
    :
else
    exit $SHOULD_EXIT
fi

# <<< Argument confirmation <<<

# Make sure file ends with a newline
FILE_PATH_TEMP="$FILE_PATH.tmp1"
sed -e '$ a \ '$'\n' "$FILE_PATH" > "$FILE_PATH_TEMP"

# Delete directories
echo "${bld}Deleting empty directories.${nrl}"
deletedDirectories=()
failedDirectories=()
while IFS=$'\n' read -r line
do 
    if [ -d "$line" ]; then
        echo "  Working on $line."
        echo "    $line is a directory."
        if [ "$TEST_MODE" == "TRUE" ]; then
            echo "    ${GRN}TEST MODE${NC}"
        else
            rm -rf "$line"
            # echo "    ${RED}NOT TEST MODE${NC}"
        fi
        result="$?"
        if [[ $result == 0 ]] ; then
            echo "    ${GRN}Directory deleted${NC}."
            deletedDirectories+=("$line")
        else
            echo "    ${RED}The directory was not deleted${NC}."
            failedDirectories+=("$line")
        fi
    fi
done < <(grep -v -e '^#' -e '^$' "$FILE_PATH_TEMP")
unset IFS

# Report results: Failed operations
echo "${bld}The following paths ${RED}were not${NC} removed.${nrl}"
echo $'\n'"${bld}Directories${nrl}:"
for path in "${failedDirectories[@]}";
do
    echo "  $path"
done

allFailedPaths+=("${failedFiles[@]}")
allFailedPaths+=("${failedLinks[@]}")
allFailedPaths+=("${failedDirectories[@]}")
allFailedPathsSorted=()
# Sort results
while read -r line;
do
    allFailedPathsSorted+=("$line");
done < <(IFS=$'\n' sort <<<"${allFailedPaths[*]}")
unset IFS

# Print results
for path in "${allFailedPathsSorted[@]}";
do
    echo "$path" >> "$OUT_PATH"
done
echo $'\n'"Failed operations were written to $OUT_PATH."

# Report results: Successful operations
echo $'\n'"${bld}The following paths ${GRN}were${NC} removed:${nrl}"
allPaths+=("${deletedFiles[@]}")
allPaths+=("${deletedLinks[@]}")
allPaths+=("${deletedDirectories[@]}")
allPathsSorted=()
# Sort results
while read -r line;
do
    allPathsSorted+=("$line");
done < <(IFS=$'\n' sort <<<"${allPaths[*]}")
unset IFS

# Print results
for path in "${allPathsSorted[@]}";
do
    echo "  $path"
done
