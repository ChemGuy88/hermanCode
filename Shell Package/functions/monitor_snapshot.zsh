#!/usr/bin/env zsh

# Provides the core-adjusted PCU and RAM usage of a system

monitor_snapshot () {
    pcpu="$(("$(ps -ax -o %cpu | awk '{s+=$1} END {print s }')" / $(sysctl -n hw.ncpu)))"
    pmem="$(ps -ax -o %mem | awk '{s+=$1} END {print s }')"
    printf "CPU usage: %.2f %%\nRAM usage: %.2f %%\n" $pcpu $pmem
}
