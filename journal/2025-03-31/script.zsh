#!/usr/bin/env zsh

# See the README.md

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
log show --start "2025-03-30 22:14:36"
         --end "2025-03-30 22:16:36"
         --info
         --debug > "log long 2025-03-30 22:15:36.log"

# Event 2 of 3
log show --start "2025-03-30 22:58:32"
         --end "2025-03-30 23:01:32"
         --info
         --debug > "log long 2025-03-30 22:59:32.log"

# Event 3 of 3
log show --start "2025-03-31 10:45:51"
         --end "2025-03-31 10:47:51"
         --info
         --debug > "log long 2025-03-31 10:46:51.log"

# Collect all log messages a minute before and after the reboot times.
# Event 1 of 3
log collect --start "2025-03-30 22:14:36" \
            --end "2025-03-30 22:16:36" \
            --info \
            --debug \
            --output "log long 2025-03-30 22:15:36.logarchive";

# Event 2 of 3
log collect --start "2025-03-30 22:58:32" \
            --end "2025-03-30 23:01:32" \
            --info \
            --output "log long 2025-03-30 22:59:32.logarchive";

# Event 3 of 3
log collect --start "2025-03-31 10:45:51" \
            --end "2025-03-31 10:47:51" \
            --info \
            --output "log long 2025-03-31 10:46:51.logarchive";
