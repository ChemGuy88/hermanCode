#!/bin/bash

RED=$'\e[0;31m'
NC=$'\e[0m'

echo "Below is the information for the package you input."

pkgutil --pkg-info "$1" # check the location

read -p "Press any key to continue." confirm

# Delete files

echo "The following files will be deleted:"

pkgutil --only-files --files "$1"

read -p "${RED}Are you sure you want to continue and delete these files?${NC} [Y/n]: " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    :
else
    echo "Exiting script."
    exit 1
fi

pkgutil --only-files --files "$1" | tr '\n' '\0' | xargs -n 1 -0 sudo rm -f

# Delete directories

echo "The following directories will be ${RED}deleted${NC} (only if empty):"

pkgutil --only-dirs --files "$1"

read -p "${RED}Are you sure you want to continue and delete these directories${NC}? [Y/n]: " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    :
else
    exit 1
fi

pkgutil --only-dirs --files "$1" | tail -r | tr '\n' '\0' | xargs -n 1 -0 sudo rmdir

echo "Removing receipt for ${RED}\"$1\"${NC}."

sudo pkgutil --forget "$1"

echo "Package completely uninstalled."
