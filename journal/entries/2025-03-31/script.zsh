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
# Shows three reboot events in the last 14 hours, from 3/30/2025 21:00 to 3/31/2025 11:00

log show --predicate 'eventMessage contains "Previous shutdown cause"' \
         --start "2025-03-30 21:00:00" \
         --end "2025-03-31 11:00:00" \
         --info \
         --debug > "log short shutdown_cause.log"

log show --predicate 'eventMessage contains "System shutdown initiated"' \
         --start "2025-03-30 21:00:00" \
         --end "2025-03-31 11:00:00" \
         --info \
         --debug > "log short shutdown_initiated.log"

# Show all log messages a minute before and after the reboot times.
# Event 1 of 3
log show --start "2025-03-30 22:14:36" \
         --end "2025-03-30 22:16:36" \
         --info \
         --debug > "log long 2025-03-30 22:15:36.log"

# Event 2 of 3
log show --start "2025-03-30 22:58:32" \
         --end "2025-03-30 23:01:32" \
         --info \
         --debug > "log long 2025-03-30 22:59:32.log"

# Event 3 of 3
log show --start "2025-03-31 10:45:51" \
         --end "2025-03-31 10:47:51" \
         --info \
         --debug > "log long 2025-03-31 10:46:51.log"

# Save all log messages a minute before and after the reboot times in JSON format.
log show --start "2025-03-30 22:14:36" \
         --end "2025-03-30 22:16:36" \
         --info \
         --debug \
         --style json > "log long 2025-03-30 22:15:36.JSON"

# Event 2 of 3
log show --start "2025-03-30 22:58:32" \
         --end "2025-03-30 23:01:32" \
         --info \
         --debug \
         --style json > "log long 2025-03-30 22:59:32.JSON"

# Event 3 of 3
log show --start "2025-03-31 10:45:51" \
         --end "2025-03-31 10:47:51" \
         --info \
         --debug \
         --style json > "log long 2025-03-31 10:46:51.JSON"

# Collect all log messages a minute before and after the reboot times in `logarchive` format
# Note that the `log collect` function has no `end` option, so the further from the event the more irrelevant data you collect.
# Events 1 to 3 of 3
log collect --start "2025-03-30 21:00:00" \
            --output "log long 2025-03-30 22:15:36.logarchive";
