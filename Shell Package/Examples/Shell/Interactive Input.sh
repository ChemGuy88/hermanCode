#!/usr/bin/env bash

# An example of a reading input interactively from the command line.
# In this example we are adding integers.

echo -n "Please enter any number of integers: "
read -a INPUT_ARRAY -r

echo "Your input is ${INPUT_ARRAY[*]}"
echo "${#INPUT_ARRAY[@]} number of elements"

num=${#INPUT_ARRAY[@]}
for ((i = 0; i < "${num}"; ++i )); do
  sum=$((sum + INPUT_ARRAY["$i"]))
done

echo "The sum of your input is $sum"
