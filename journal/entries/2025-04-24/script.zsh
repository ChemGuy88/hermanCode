#!/usr/bin/env zsh

# See the README.md for background information

# This script must be run as `sudo` to run `log collect`
echo "This script must be run as sudo. Hit [enter] to continue or else quit."
read -r -u 0 response
if [[ -z "$response" ]]; then
    :
else
    exit 1
fi

# `log` is a Z-shell built-in so it will conflict with the macOS `log`. We use `alias` to point straight to the desired command.
# See https://egeek.me/2019/05/04/osx-timemachine-and-log-too-many-arguments/
alias log="/usr/bin/log"

# Make sure you are an admin on the iMac
last > last.log
# Shows one reboot event in the last 24 hours at 4/23/2025 23:46.

log show --predicate 'eventMessage contains "Previous shutdown cause"' \
         --start "2025-04-23 23:16:00" \
         --end "2025-04-24 00:46:00" \
         --info \
         --debug > "log short shutdown_cause.log"

log show --predicate 'eventMessage contains "System shutdown initiated"' \
         --start "2025-04-23 23:16:00" \
         --end "2025-04-24 00:46:00" \
         --info \
         --debug > "log short shutdown_initiated.log"

# Show all log messages five minutes before and after the reboot times.
# Event 1 of 1
log show --start "2025-04-23 23:41:23" \
         --end "2025-04-23 23:51:23" \
         --info \
         --debug > "log long 2025-04-23 23:46:23.log"

# Save all log messages five minutes before and after the reboot times in JSON format.
log show --start "2025-04-23 23:41:23" \
         --end "2025-04-23 23:51:23" \
         --info \
         --debug \
         --style json > "log long 2025-04-23 23:46:23.JSON"

# Collect all log messages ten minutes before and after the reboot times in `logarchive` format.
# Note that the `log collect` function has no `end` option, so the further from the event the more irrelevant data you collect.
# Events 1 to 1 of 3
log collect --start "2025-04-23 23:36:23" \
            --output "log long 2025-04-23 23:46:23.logarchive";
