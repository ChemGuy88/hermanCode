#!/usr/bin/env bash

# Print a command too long for `echo` by using `cat`.

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
GRN=$'\e[0;32m'
NC=$'\e[0m'

array_of_parameters=("parameter_1" \
           "parameter_2" \
           "parameter_3")

# Show array elements
echo " ${bld}${GRN}>>>${nrl}${NC} Print command executed on an array of parameters. ${bld}${GRN}>>>${nrl}${NC}"
for parameter in "${array_of_parameters[@]}";
do
    command_as_text="$(cat <<TOKEN_FOR_CAT
    echo "$parameter"
TOKEN_FOR_CAT
)"
    echo "$command_as_text"
done
echo " ${bld}${GRN}<<<${nrl}${NC} Print command executed on an array of parameters. ${bld}${GRN}<<<${nrl}${NC}"
