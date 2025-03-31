# 2025-03-31

On 3/30/2025 the iMac unexplicably restarted. This is concerning and warrants investigation because we need the iMac to run uninterrupted for our project. What follows is the result of our sleuthing.

```zsh
ssh imacl
```

```zsh
last > last.log
# Shows three reboot events in the last 14 hours, from 3/30/2025 21:00 to 3/31/2025 11:00
```

```zsh
log show --predicate 'eventMessage contains "Previous shutdown cause"' \
         --start "2025-03-30 21:00:00" \
         --end "2025-03-31 11:00:00" \
         --info \
         --debug > "log short shutdown_cause.log"
```

```zsh
log show --predicate 'eventMessage contains "System shutdown initiated"' \
         --start "2025-03-30 21:00:00" \
         --end "2025-03-31 11:00:00" \
         --info \
         --debug > "log short shutdown_initiated.log"
```

```zsh
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
```

```zsh
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
```

`log collect` had the following feedback:

```text
log: uuid text missing: /private/var/db/uuidtext/68/2A7D87E94D3720BB97E5C478982456: No such file or directory (2)
log: uuid text missing: /private/var/db/uuidtext/6F/27509E8BA53FBD803F3835725905E7: No such file or directory (2)
log: uuid text missing: /private/var/db/uuidtext/CC/32C8AAF95E33E7BB4AF793FCE7A2AE: No such file or directory (2)
log: uuid text missing: /private/var/db/uuidtext/95/AEDA2E3E9E3995B8E9F5581AE50EFC: No such file or directory (2)
```

The article ends here, with further research pending into the generated `logarchive` files.

# References

- [A blog](https://www.mac4n6.com/blog/2020/4/26/analysis-of-apple-unified-logs-quarantine-edition-entry-4-its-login-week)
- [Another blog](https://timnash.co.uk/macos-restarting-logging-out-when-screen-locked/#:~:text=log%20show%20%2D%2Dpredicate%20'eventMessage%20contains%20%22sessionlogoutd%22'%20%2D%2D,it's%20logging%20my%20user%20out.)
- Google `what is "sessionlogoutd"`
