#!/bin/bash

# shellcheck source="/home/herman/.hermanCode/functions.bash"
source "/home/herman/.hermanCode/functions.bash"

usage() {
    cat <<USAGE
Merges folders.
$0 -p <PATHS> -f <FROM_PREFIX> -o <TO_PREFIX> -t TRUE|FALSE
    -k The keyword to search for. Use multiple -k for search for multiple keywords.
    -t The script test flag. One of TRUE or FALSE.
USAGE
    exit 1
}

# >>> Argument parsing >>>
while getopts ":o:f:p:t" opt; do
    case "${opt}" in
        p) PATHS+=("$OPTARG");;
        f) FROM_PREFIX=${OPTARG};;
        o) TO_PREFIX=${OPTARG};;
        t) TEST_MODE=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

if [ -z "${TEST_MODE}" ]; then
    usage
fi
# <<< Argument parsing <<<

# >>> Argument confirmation >>>
SHOULD_EXIT=0

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

# Print arguments
echo "TEST_MODE = ${TEST_MODE}"

if [ "$SHOULD_EXIT" -eq 0 ]; then
    :
else
    exit $SHOULD_EXIT
fi
# <<< Argument confirmation <<<

# >>> Script body >>>
echo "$(timeStamp) Begin script."
for fromPath0 in "${PATHS[@]}"; do
    # Convert relative path to absolute path
    echo "  Working on path \"$fromPath0\"."
    fromPath="$FROM_PREFIX/$fromPath0"
    toPath="$TO_PREFIX/$fromPath0"
    # Check if item is file or directory
    # -> If file, get directory name
    # -> If directory, set directory name
    if [ -f "$fromPath" ]; then
        toDir="$(dirname "$toPath")"
    elif [ -d "$fromPath" ]; then
        toDir="$toPath"
    else
        echo "  ???"
    fi
    # Make directory and all parents
    if [ "$TEST_MODE" == "TRUE" ]; then
        echo "    \`toDir\`:    \"$toDir\"."
    elif [ "$TEST_MODE" == "FALSE" ]; then
        mkdir --parents "$toDir"
    else
        exit 1
    fi
    # Copy item
    if [ "$TEST_MODE" == "TRUE" ]; then
        echo "    \`fromPath\`: \"$fromPath\"."
        echo "    \`toPath\`:   \"$toPath\"."
    elif [ "$TEST_MODE" == "FALSE" ]; then
        cp "$fromPath" "$toPath"
    else
        exit 1
    fi

done

echo "$(timeStamp) End script."
# <<< Script body <<<
