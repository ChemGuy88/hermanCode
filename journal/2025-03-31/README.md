# 2025-03-31

On 3/30/2025 the iMac unexplicably restarted. This is concerning and warrants investigation because we need the iMac to run uninterrupted for our project. What follows is the result of our sleuthing.

Log on to the iMac as an administrator and run `./script.zsh` as `sudo`

```zsh
ssh imacl
cd $this_directory
sudo script.zsh
```

When the script finished running `log collect` had the following feedback:

```text
log: uuid text missing: /private/var/db/uuidtext/68/2A7D87E94D3720BB97E5C478982456: No such file or directory (2)
log: uuid text missing: /private/var/db/uuidtext/6F/27509E8BA53FBD803F3835725905E7: No such file or directory (2)
log: uuid text missing: /private/var/db/uuidtext/CC/32C8AAF95E33E7BB4AF793FCE7A2AE: No such file or directory (2)
log: uuid text missing: /private/var/db/uuidtext/95/AEDA2E3E9E3995B8E9F5581AE50EFC: No such file or directory (2)
```

The script otherwise ran without any errors. That is the extect of my investigation so far, with further research pending into the generated `logarchive` files. I could probably play around with different `log show --predicate '...'` calls until I find something that pinpoints what caused the unplanned reboot.

# References

- [A blog](https://www.mac4n6.com/blog/2020/4/26/analysis-of-apple-unified-logs-quarantine-edition-entry-4-its-login-week)
- [Another blog](https://timnash.co.uk/macos-restarting-logging-out-when-screen-locked/#:~:text=log%20show%20%2D%2Dpredicate%20'eventMessage%20contains%20%22sessionlogoutd%22'%20%2D%2D,it's%20logging%20my%20user%20out.)
- Google `what is "sessionlogoutd"`
