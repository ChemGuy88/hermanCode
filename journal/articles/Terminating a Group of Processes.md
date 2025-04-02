# Terminating a Group of Processes

```shell
pkill -TERM -Il -g $PROCESS_ID_NUMBER
```

## Explanation

`-TERM` is the signal to send. It's the default value, but for increased peace of mind you can explicitely mention in the command.

`-I` asks for confirmation. A simple <kbd>⏎ Enter</kbd> is sufficient confirmation.

`-l` displays the kill command used for each process killed.

`-g` is for _process group ID_, or what appears as `PGID` in the output of `ps` with the `-o pgid` option. Don't confuse this `PGID` for what `pkill`/`pgrep` call `gid`, or _real group ID_, which is called with the `-G` option.

`$PROCESS_ID_NUMBER` is of course your `pid`, an integer like `123`.
