#!/usr/bin/env zsh

usage_help () {
    cat <<USAGE
Program assumptions
1. Expects only one argument: DIRECTORY_PATH, the path to a directory. This directory contains shell files with file names that match the regular expression \`[:digit:]+\.[:alpha:]*sh\`. That is, the file names must be numbers with or without leading zeros and the file extension must be \`.sh\`, \`.bash\`, or something similar.
2. Each file represents a single PostgreSQL user, with a single password, and any number of databases (i.e, zero or more). The databases will be created with that user's ownership.
3. There must be at least one file (i.e., user), and it must meet the following two criteria:
   3.1. It must represent the PostgreSQL server administrator.
   3.2. It must be, ordinally, the first file. This means that if there are two files, 1.sh and 2.sh, it must be 1.sh. Or if there are two files, 2.sh and 3.sh, it must be 2.sh.
   3.3. 
4. All files must have exactly three variables with the following exact names
   4.1. \`USERNAME\`, a string scalar
   4.2. \`PASSWORD\`, a string scalar
   4.3. \`DATABASE\`, an array of strings
USAGE
}

usage() {
    cat <<USAGE
usage: setup_pg DIRECTORY_PATH

Add roles and databases to a PostgreSQL server.

arguments:
    DIRECTORY_PATH      The path to the directory containing shell scripts with user information.

options:
    -h                  Print this usage text with additional information.
    -v                  Verbose mode. Print feedback while working.
USAGE
}
usage_error() {
    echo "Error code $1: $2"
    echo ""
    usage 1>&2
    exit $1
}

# Formatting
bld=$(tput bold)
nrl=$(tput sgr0)
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

while getopts "d:hv" opt; do
    case "${opt}" in
        d) directory_path=${OPTARG};;
        h) print_help="TRUE";;
        v) verbose_mode="TRUE";;
        *) usage_error 1;;
    esac
done

# >>> Argument confirmation >>>

# Assert only one program form selected
if [ -z "${directory_path+x}" ] && [ -z "${print_help+x}" ]; then
    usage_error 2 "Too few options or arguments passed. Choose one program form."
# elif [ [ -n "${directory_path+x}" ] || [ -n "${verbose_mode}" ] ] && [ -n "${print_help+x}" ]; then
elif [ -n "${directory_path+x}" ] && [ -n "${print_help+x}" ] || [ -n "${verbose_mode}" ] && [ -n "${print_help+x}" ] && ; then
    usage_error 3 "Too many options or arguments passed. Choose one program form."
fi


# `print_help`
if [ -z "${print_help+x}" ]; then
    :
else
    if [[ "$print_help" =~ (FALSE|TRUE) ]]; then
        echo "\`print_help\`: \"$print_help\""
    else
        usage_error 4 "Bad print help argument: $print_help"
    fi
fi

# `verbose_mode`
if [ -z "${verbose_mode+x}" ]; then
    :
else
    if [[ "$verbose_mode" =~ (FALSE|TRUE) ]]; then
        echo "\`verbose_mode\`: \"$verbose_mode\""
    else
        usage_error 5 "Bad verbose mode argument: $verbose_mode"
    fi
fi

# `directory_path`
if [ -z "${directory_path+x}" ]; then
    :
else
    echo "\`directory_path\`: \"$directory_path\""
fi
# <<< Argument confirmation <<<

# Form 1: Print help
if [[ "$print_help" == "TRUE" ]]; then
    usage_help
    exit 0
fi

# Form 2: Create user databases
# Assert we are using the right PostgreSQL version, since the PostgresQL commands are for version 16.
psql_version_string=$(psql -V)
if [[ "$psql_version_string" =~ (([0-9]+).[0-9]) ]];
then
    minor_version="$match[1]";
    major_version="$match[2]";
    if [[ "$major_version" == 16 ]];
    then
        :
        echo "Setting up PostgresQL users and databases."
    else
        echo "This script is only implemented for PostgresQL version 16"
        exit 1
    fi
else
    echo "Could not identify the psql version from the string \"$psql_version_string\""
    exit 1
fi

# >>> Load data >>>

# >>> Load data: files array >>>
# Numerically sorted file names from the input directory
files_list=$(ls "$directory_path" | sort -g)
files_array=()
while read -r line; do
    if [[ "$line" =~ ^[[:digit:]]+\..*sh$ ]]; then
        files_array+=("$line");
    fi
done < <(echo $files_list)

if [[ "$verbose_mode" == "TRUE" ]]; then
    echo "Input files ${bld}${RED}before${nrl}${NC} filtering:
$files_list"
    echo "Input files ${bld}${GRN}after${nrl}${NC} filtering:"
    for arr_el in "${files_array[@]}"; do
        echo "  - $arr_el"
    done
fi
# <<< Load data: files array <<<

header_message="Setting up user databases"
echo "$header_message"
it_pgu=$((0))                # Iterate over files/PostgreSQL users
it_pgu_n=${#files_array[@]}  # Get count of `files_array`
for fname in ${files_array[@]}; do
    it_pgu=$((it_pgu + 1))
    echo "  Working on file (user) $it_pgu of $it_pgu_n: \"$fname\""
    # Load data from file
    source "$directory_path/$fname"
    username="$PGU_USERNAME"
    password="$PGU_PASSWORD"
    database_array=(${PGU_DATABASE[@]})
    options_array=(${PGU_OPTIONS[@]})

    # Verbose feedback
    if [[ "$verbose_mode" == "TRUE" ]]; then
        echo "  Username: $username
  Password: <censored>"
    fi

    # Set admin variables
    if [[ $it_pgu == 1 ]]; then
        POSTGRESQL_ADMIN_USERNAME="$username"
        POSTGRESQL_ADMIN_DATABASE="${database_array[1]}"
        # Verbose feedback
        if [[ "$verbose_mode" == "TRUE" ]]; then
            echo "This is the admin user, skipping database creation."
        fi
    else
        # >>> Setup Databases >>>
        if [[ "$verbose_mode" == "TRUE" ]]; then
            echo "Using admin credentials for \"$POSTGRESQL_ADMIN_USERNAME\""
        fi

        # Drop database if it exists
        it_db=$((0))                   # Iterate over databases
        it_db_n=${#database_array[@]}  # Get count of `database_array`
        for database in ${database_array[@]}; do
            it_db=$((it_db + 1))
            echo "    Removing database $it_db of $it_db_n: $database."
            psql -U "$username" \
                 -d "$POSTGRESQL_ADMIN_DATABASE" \
                 -c "DROP DATABASE IF EXISTS \"$database\";"
        done

        # Drop user if it exists
        psql -U "$POSTGRESQL_ADMIN_USERNAME" \
                -c "DROP USER IF EXISTS $username;"

        # Create user
        options_string="${options_array[*]}"
        psql -U "$POSTGRESQL_ADMIN_USERNAME" \
             -c "CREATE USER $username WITH PASSWORD '$password' $options_string;"

        # Create database
        it_db=$((0))
        for database in ${database_array[@]}; do
            it_db=$((it_db + 1))
            echo "    Setting up database $it_db of $it_db_n: $database."
            psql -U "$username" \
                 -d "$POSTGRESQL_ADMIN_DATABASE" \
                 -c "CREATE DATABASE \"$database\" OWNER \"$username\""
        done

        # Confirm creation
        psql -U "$username" \
             -d "$database" \
             -c "SELECT usename FROM pg_catalog.pg_user WHERE usename = '$username';"

        # <<< Setup Databases <<<
    fi

done
echo "$header_message - Done."
