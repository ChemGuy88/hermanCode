#!/bin/bash
# h/t to https://stackoverflow.com/questions/7529856/retrieving-multiple-arguments-for-a-single-option-using-getopts-in-bash
# h/t to https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash

usage0() {
    cat <<USAGE
This is an example of how ot use argument parsing using "getopts"

$0 -k <TRACE_KEYWORDS> -t TRUE|FALSE

    -k The keyword to search for. Use multiple -k for search for multiple keywords.
    -t The script test flag. One of TRUE or FALSE.
USAGE
}
usage() {
    usage0 1>&2
    exit 1
}

while getopts ":k:t:" opt; do
    case "${opt}" in
        k) trace_keyword+=("$OPTARG");;
        t) test_mode=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

if [ -z "${trace_keyword[*]}" ] || [ -z "${test_mode}" ]; then
    usage
fi

echo "The first value of the array 'trace_keyword' is '$trace_keyword'"
echo "The whole list of values is '${trace_keyword[*]}'"

echo "Or:"

for val in "${trace_keyword[@]}"; do
    echo " - $val"
done

echo "The first value of the array 'test_mode' is '$test_mode'"
echo "The whole list of values is '${test_mode[*]}'"

echo "Or:"

for val in "${test_mode[@]}"; do
    echo " - $val"
done