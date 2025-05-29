#!/usr/bin/env zsh

# Provides the core-adjusted PCU and RAM usage of a system

monitor_snapshot () {
    pcpu_1="$(ps -ax -o %cpu | awk '{s+=$1} END {print s }')"
    pcpu_2="$(sysctl -n hw.ncpu)"
    pcpu="$(bc -e "$pcpu_1 / $pcpu_2")"
    pmem="$(ps -ax -o %mem | awk '{s+=$1} END {print s }')"
    printf "CPU usage: %.2f %%\nRAM usage: %.2f %%\n" $pcpu $pmem
}
