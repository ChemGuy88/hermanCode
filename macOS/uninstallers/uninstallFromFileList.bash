#!/bin/bash

# KNOWN BUGS: If the file at FILE_PATH does not end with an empty newline, the last line will not be read.

# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

# >>> Argument parsing >>>
POSITIONAL_ARGS=()

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -f|--filepath)
      FILE_PATH="$2"
      shift # past argument
      shift # past value
      ;;
    -t|--test_mode)
      TEST_MODE="$2"
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# <<< Argument parsing <<<

# >>> Argument confirmation >>>
SHOULD_EXIT=0

# $FILE_PATH
if [[ ! -n "$FILE_PATH" ]]; then
    echo "${RED}You must supply a file path${NC}."
    SHOULD_EXIT=1
fi

# $TEST_MODE
MESSAGE="${RED}TEST_MODE must be one of "TRUE" or "FALSE"${NC}."
if [ ! -n "$TEST_MODE" ]; then
    echo $MESSAGE
    SHOULD_EXIT=1
else
    if [ "$TEST_MODE" == "TRUE" ] || [ "$TEST_MODE" == "FALSE" ]; then
        :
    else
        echo $MESSAGE
        SHOULD_EXIT=1
    fi
fi

# Argument confirmation
echo "FILE_PATH = ${FILE_PATH}"
echo "TEST_MODE = ${TEST_MODE}"

if [ "$SHOULD_EXIT" -eq 0 ]; then
    :
else
    exit $SHOULD_EXIT
fi

# <<< Argument confirmation <<<

# Delete files and links first
echo "${bold}Deleting files and links first.${normal}"
deletedFiles=()
deletedLinks=()
failedFiles=()
failedLinks=()
while IFS=$'\n' read line
do
    if [ -f "$line" ] || [ -L "$line" ]; then
        echo "  Working on "$line""
        if [ -f "$line" ]; then
            echo "    $line is a file."
            if [ "$TEST_MODE" == "TRUE" ]; then
                echo "    ${GRN}TEST MODE${NC}"
            else
                rm "$line"
                # echo "    ${RED}NOT TEST MODE${NC}"
            fi
            result="$?"
            if [[ $result == 0 ]]; then
                echo "    ${GRN}File deleted${NC}."
                deletedFiles+=("$line")
            else
                echo "    ${RED}The file was not deleted${NC}."
                failedFiles+=("$line")
            fi
        elif [ -L "$line" ]; then
            echo "    $line is a symbolic link."
            if [ "$TEST_MODE" == "TRUE" ]; then
                echo "    ${GRN}TEST MODE${NC}"
            else
                rm "$line"
                # echo "    ${RED}NOT TEST MODE${NC}"
            fi
            result="$?"
            if [[ $result == 0 ]]; then
                echo "    ${GRN}Link deleted${NC}."
                deletedLinks+=("$line")
            else
                echo "    ${RED}The link was not deleted${NC}."
                failedLinks+=("$line")
            fi
        else
            :
        fi
    fi
done < "$FILE_PATH"
unset IFS

# Delete empty directories
echo "${bold}Deleting empty directories.${normal}"
deletedDirectories=()
failedDirectories=()
while IFS=$'\n' read line
do 
    if [ -d "$line" ]; then
        echo "  Working on "$line"."
        echo "    $line is a directory."
        if [ "$TEST_MODE" == "TRUE" ]; then
            echo "    ${GRN}TEST MODE${NC}"
        else
            rmdir "$line"
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
done < "$FILE_PATH"
unset IFS

# Report results
echo "${bold}The following paths ${RED}were not${NC} removed.${normal}"
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

echo $'\n'"${bold}The following paths ${GRN}were${NC} removed:${normal}"

# Method 1
allpaths=()
allPaths+=("${deletedFiles}")
allPaths+=("${deletedLinks}")
allPaths+=("${deletedDirectories}")
IFS=$'\n' allPathsSorted=($(sort <<<"${allPaths[*]}"))
unset IFS
for path in "${allPathsSorted[@]}";
do
    echo "  $path"
done
