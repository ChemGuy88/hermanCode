#!/bin/bash

while read line
do
    xargs -o -I{} "/Users/herman/.hermanCode/macOS/uninstallWithPkgutil.bash" {}
done < "$1"