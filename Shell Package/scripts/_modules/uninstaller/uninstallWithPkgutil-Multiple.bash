#!/usr/bin/env bash

while read line
do
    xargs -o -I {} "Shell Package/scripts/_modules/uninstaller/uninstallWithPkgutil.bash" {}
done < "$1"
