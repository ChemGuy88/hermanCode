#!/usr/bin/env bash

while read line
do
    xargs -o -I {} "Shell Package/macOS/uninstallWithPkgutil.bash" {}
done < "$1"
