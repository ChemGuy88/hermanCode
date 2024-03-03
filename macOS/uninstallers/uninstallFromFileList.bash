#!/bin/bash

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
RED=$'\e[0;31m'
NC=$'\e[0m'

# Delete files and links first
echo "${bold}Deleting files and links first.${normal}"
failedFiles=()
failedLinks=()
while read line
do
    if [ -f "$line" ] || [ -L "$line" ]; then
        echo "  Working on "$line""
        if [ -f "$line" ]; then
            echo "    $line is a file."
            # sudo rm "$line"
            result="$?"
            if [[ result == 0 ]]; then
                echo "    File deleted."
            else
                echo "    ${RED}The file was not deleted.${NC}"
                failedFiles+="$line"
            fi
        elif [ -L "$line" ]; then
            echo "    $line is a symbolic link."
            # sudo rm "$line"
            result="$?"
            if [[ result == 0 ]]; then
                echo "    Link deleted."
            else
                echo "    ${RED}The link was not deleted.${NC}"
                failedLinks+="$line"
            fi
        else
            :
        fi
    fi
done < "$1"

# Delete empty directories
echo "${bold}Deleting empty directories.${normal}"
failedDirectories=()
while read line
do 
    if [ -d "$line" ]; then
        echo "  Working on "$line"."
        echo "    $line is a directory."
        # sudo rmdir "$line"
        result="$?"
        if [[ result == 0 ]] ; then
            echo "    Directory deleted."
        else
            echo "    ${RED}The directory was not deleted.${NC}"
            failedDirectories+="$line"
        fi
    fi
done < "$1"

# Report results
echo "${bold}The following paths were not removed:${normal}"
echo $'\n'"${bold}Files${normal}:"
for path in "${failedFiles[@]}";
do
    echo "  $path"
done
echo $'\n'"${bold}Links${normal}:"
for path in "${failedLinks[@]}";
do
    echo "  $path"
done
echo $'\n'"${bold}Directories${normal}:"
for path in "${failedDirectories[@]}";
do
    echo "  $path"
done