#!/bin/bash
# add1 : adding user supplied ints

echo -n "Please enter any number of integers: "
read -a -r input

echo "Your input is ${input[*]}"
echo "${#input[@]} number of elements"

num=${#input[@]}   # causing error
for ((i = 0; i < "${num}"; ++i )); do  # causing error
  sum=$((sum + input["$i"]))
done

echo "The sum of your input is $sum"
