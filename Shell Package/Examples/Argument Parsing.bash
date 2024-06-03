#!/bin/bash
# h/t to https://stackoverflow.com/questions/7529856/retrieving-multiple-arguments-for-a-single-option-using-getopts-in-bash
# h/t to https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash

usage0() {
    cat <<USAGE
This is an example of how to use argument parsing using "getopts".

"$(basename "$0")" -a <ARGUMENT> -b TRUE|FALSE

    -a An argument to add to an array. Use multiple \`-a\` for multiple arguments.
    -b A boolean argument, one of {TRUE, FALSE}. Case sensitive.
USAGE
}
usage() {
    usage0 1>&2
    exit 1
}

while getopts ":a:b:" opt; do
    case "${opt}" in
        a) ARGUMENT_ARRAY+=("$OPTARG");;
        b) BOOLEAN_ARGUMENT=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

# >>> Argument confirmation >>>
# `ARGUMENT_ARRAY`
if [ -z "${ARGUMENT_ARRAY[*]}" ]; then
    usage
fi
# `BOOLEAN_ARGUMENT`
if [ "$BOOLEAN_ARGUMENT" == "TRUE" ] || [ "$BOOLEAN_ARGUMENT" == "FALSE" ]; then
    :
else
    usage
fi

echo "The first value of the argument array 'ARGUMENT_ARRAY' is '$ARGUMENT_ARRAY'"
echo "The whole list of values is '${ARGUMENT_ARRAY[*]}'"

echo "Or:"

for val in "${ARGUMENT_ARRAY[@]}"; do
    echo " - $val"
done

echo "The value of the argument 'BOOLEAN_ARGUMENT' is '$BOOLEAN_ARGUMENT'"
# <<< Argument confirmation <<<
