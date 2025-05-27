# Get Total and Available Disk Space

```zsh
df -H | awk '/\/dev\/disk1s1/ {printf("%s\n%s\n", $2,$4)}'
```

From [*Ask Different*](]https*://apple.stackexchange.com/questions/325679/diskutil-get-total-and-available-space-on-macos-using-apfs)
