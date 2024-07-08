#!/bin/bash

usage0() {
    cat <<USAGE
This is an example of how to parse case insensitive string arguments.

"$(basename "$0")" -b TRUE|FALSE
                   -c True|False
                   -d [t|T[rue]]|[f|F[alse]]

    -b A boolean argument, one of {TRUE, FALSE}. Case sensitive.
    -c A boolean argument, one of {TRUE, FALSE}. Case in-sensitive.
    -d A boolean argument, one of {T[RUE], F[ALSE]}. Case in-sensitive.
USAGE
}
usage() {
    usage0 1>&2
    exit 1
}

while getopts ":b:c:d:" opt; do
    case "${opt}" in
        b) BOOLEAN_ARGUMENT_1=${OPTARG};;
        c) BOOLEAN_ARGUMENT_2=${OPTARG};;
        d) BOOLEAN_ARGUMENT_3=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND -1))

# >>> Argument confirmation >>>
# `BOOLEAN_ARGUMENT`
if [ "$BOOLEAN_ARGUMENT_1" == "TRUE" ] || [ "$BOOLEAN_ARGUMENT_1" == "FALSE" ]; then
    :
else
    invalid_arguments=1
fi

if [[ "$BOOLEAN_ARGUMENT_2" == [tT][rR][uU][eE] ||  "$BOOLEAN_ARGUMENT_2" == [fF][aA][lL][sS][eE] ]]; then
    :
else
    invalid_arguments=1
fi

shopt -s nocasematch &&
if [[ "$BOOLEAN_ARGUMENT_3" =~ (t|true) ||  "$BOOLEAN_ARGUMENT_3" =~ (f|false) ]]; then
    :
else
    invalid_arguments=1
fi &&
shopt -u nocasematch 

echo "The value of the argument 'BOOLEAN_ARGUMENT_1' is '$BOOLEAN_ARGUMENT_1'"
echo "The value of the argument 'BOOLEAN_ARGUMENT_2' is '$BOOLEAN_ARGUMENT_2'"
echo "The value of the argument 'BOOLEAN_ARGUMENT_3' is '$BOOLEAN_ARGUMENT_3'"

if [[ "$invalid_arguments" == 1 ]]; then
    echo "You provided invalid arguments"
    usage
fi
# <<< Argument confirmation <<<

echo "Program ran successfully" && exit 0
