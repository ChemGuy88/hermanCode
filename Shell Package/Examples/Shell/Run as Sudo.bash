#!/usr/bin/env bash

# Always run script as sudo

if [[ $(id -u) -ne 0 ]]; then
    sudo "$0" "$@";
    exit 0;
fi
