#!/bin/bash

# shellcheck source="Shell Package/functions/functions.bash"
source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/functions.bash"

# Formatting
RED=$'\e[0;31m'
NC=$'\e[0m'

usage0() {
    cat <<USAGE
HINT 1: Run this as \`sudo\` to prevent getting \`access denied\` errors.
HINT 2: You might need to preserve the environment variables when using \`sudo\`, so do \`sudo -E findTraces.sh -k KEYWORD -t TRUE\`.

This BASH script uses \`find\` to search your entire machine (including mounted volumes)
to find the passed <TRACE_KEYWORDS>. By default this runs in the background. You can check
the progress by inspect the output directory \`~/Find Traces\`, or using \`getPgrep
<USERNAME> "Find Traces"\`.

$0 -k <TRACE_KEYWORDS> -t TRUE|FALSE

    -k The keyword to search for. Use multiple -k for search for multiple keywords.
    -t The script test flag. One of TRUE or FALSE.
USAGE
}

usage() {
    usage0 1>&2
    exit 1
}


# >>> Argument parsing >>>
DIRECTORY="/"
while getopts ":k:d:t:" opt; do
    case "${opt}" in
        k) TRACE_KEYWORDS+=("$OPTARG");;
        d) DIRECTORY=${OPTARG};;
        t) TEST_MODE=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

if [ -z "${TRACE_KEYWORDS[*]}" ] || [ -z "${TEST_MODE}" ] || [ -z "${DIRECTORY}" ]; then
    usage
fi
# <<< Argument parsing <<<

# >>> Argument confirmation >>>
SHOULD_EXIT=0

# $TRACE_KEYWORDS
if [[ -z "$TRACE_KEYWORDS" ]]; then
    echo "${RED}You must supply a keyword to search for${NC}."
    SHOULD_EXIT=1
fi

# $DIRECTORY
if [[ -z "$DIRECTORY" ]]; then
    echo "${RED}You must supply the directory path to search in${NC}."
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
echo "TRACE_KEYWORDS:"
for val in "${TRACE_KEYWORDS[@]}"; do
    echo "  - $val"
done
echo "DIRECTORY = ${DIRECTORY}"
echo "TEST_MODE = ${TEST_MODE}"

if [ "$SHOULD_EXIT" -eq 0 ]; then
    :
else
    exit $SHOULD_EXIT
fi
# <<< Argument confirmation <<<


FIND_TRACES_DIRECTORY=~/"Find Traces/$(getTimestamp)"
if ! [ -d "$FIND_TRACES_DIRECTORY" ]; then
    if [ "$TEST_MODE" == "FALSE" ]; then
        mkdir -p "$FIND_TRACES_DIRECTORY"
        echo "This directory was created by 'findTraces.sh'" > "$FIND_TRACES_DIRECTORY/README.md"
    fi
    echo "Made directory at $FIND_TRACES_DIRECTORY"
elif [ -d "$FIND_TRACES_DIRECTORY" ]; then
    echo "Directory already exists: $FIND_TRACES_DIRECTORY"
fi

for keyword in "${TRACE_KEYWORDS[@]}";
do
    if [ "$TEST_MODE" == "FALSE" ]; then
        nohup find "$DIRECTORY" -iname "*$keyword*" 1> "$FIND_TRACES_DIRECTORY/$keyword.out" 2> "$FIND_TRACES_DIRECTORY/$keyword.err" &
    else
        :
    fi
done

echo "Scripts are running."
