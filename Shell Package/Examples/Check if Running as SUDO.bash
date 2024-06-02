#!/usr/bin/env bash

# shellcheck disable=SC2320

# Check if a script is being run as the super-user "SUDO".

# Formatting
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

echo "\$_ is: \"$_\""
echo "\$? is \"$?\""
if [ -z "$*" ]; then
    echo "No arguments were passed"
else
    echo "Printing each argument iteratively:"
    it=0
    for argument in "$@"; do
        it=$((it+1))
        echo " $it - $argument"
    done
    echo ""

    echo "Printing all arguments at once: \"${*}\""
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "${RED}Please run this script as root or using \`sudo\`${NC}."
    exit 1
fi

echo "${GRN}This file was run successfully as \`sudo\`${NC}."
