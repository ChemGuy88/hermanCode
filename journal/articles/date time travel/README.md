# README

An interest problem arose from using `date +%M` and `date +%s`. It seems that when the minute changes, the seconds are registered before the minute, so if you concatenate the minutes and seconds you get a display like this

```text
1:58
1:59
1:00
2:00
2:01
2:02
```

This bug is illustrated in `./example_bug.sh` and its output `./example_bug.text`. You can find the instance when it happens by searching for the string `condition is met`. The resolution is implemented in `./example_fix.sh`.
