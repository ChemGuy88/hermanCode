# Monitoring Processes

How to monitor processes on the command line.

# Introduction

You can monitor the total resource consumption of a system by piping `ps` into `awk`.

```zsh
ps -ax -o %cpu | awk '{s+=$1} END {print s "%"}'
# for RAM, use
ps -ax -o %mem | awk '{s+=$1} END {print s "%"}'
```

Note that the documentation for `ps` is confusing, and one might think that `-A` is not the same as `-ax`, but in practice it is. This is partially explained in a [SuperUser post](https://superuser.com/a/902017). The post only explains the discrepancy for BASH and Unix environments, but it's possible that other environments have the discrepancy because for similar reasons; We can demonstrate by counting the number of processes using the `ps` variable names with special meanings. Note we subtract by one because we want don't want to count the header from `ps`.

```zsh
ps -ax -o %cpu | awk '{s+=$1} END {print s "% for " NR-1 " processes"}'
ps -ax -o %mem | awk '{s+=$1} END {print s "% for " NR-1 " processes"}'

# Testing all combinations of the A, a, and x options.
ps -ax | awk 'END {print "Number of processes:" NR-1}'      # Group 1
ps -a -x | awk 'END {print "Number of processes:" NR-1}'    # Group 1
ps -A | awk 'END {print "Number of processes:" NR-1}'       # Group 1
ps -Ax | awk 'END {print "Number of processes:" NR-1}'      # Group 1
ps -A -x | awk 'END {print "Number of processes:" NR-1}'    # Group 1
ps a | awk 'END {print "Number of processes:" NR-1}'        # Group 2
ps x | awk 'END {print "Number of processes:" NR-1}'        # Group 3
ps -a | awk 'END {print "Number of processes:" NR-1}'       # Group 2
ps -x | awk 'END {print "Number of processes:" NR-1}'       # Group 3
ps ax | awk 'END {print "Number of processes:" NR-1}'       # Group 1
```

In our environment, Z shell on macOS 15.3.2, the above commands can be grouped into three equivalent groups. That means that all the commands in group 1 gave the same result, all the commands in group 2 gave the same result, etc.

# Using Herman's Code to monitor processes

Using `pgrep` or `getPgrep`, find a processes or a group of processes you want to monitor and note their process IDs `pid`.

```zsh
getPgrep user_name keyword_to_grep
```

```text
STARTED                        PID  PGID  PPID TTY           TIME COMMAND
Tue Apr  1 09:25:40 2025     18790 18787     1 ??         0:01.02 parent_command_1 arg_1 arg_2
Tue Apr  1 09:25:41 2025     18793 18787 18790 ??         0:00.04 subprocess_1_1
Tue Apr  1 09:25:41 2025     18794 18787 18790 ??         0:02.81 subprocess_1_2
Tue Apr  1 09:25:41 2025     18795 18787 18790 ??         0:11.49 subprocess_1_3
Tue Apr  1 09:25:45 2025     18817 18787     1 ??         0:00.85 parent_command_2 arg_1 arg_2
Tue Apr  1 09:25:45 2025     18818 18787 18817 ??         0:00.04 subprocess_2_1
Tue Apr  1 09:25:45 2025     18819 18787 18817 ??         1:16.61 subprocess_2_2
Tue Apr  1 09:25:45 2025     18820 18787 18817 ??         1:00.77 subprocess_2_3
Tue Apr  1 12:40:21 2025     21501 21501 21500 ttys001    0:00.06 -zsh
Tue Apr  1 12:40:22 2025     21525 21524 21501 ttys001    0:00.00 xargs --no-run-if-empty ps -o lstart -o pid -o pgid -o ppid -o tty -o time -o command
```

If you have a large group of processes which have a common process group ID, you can programmatically pass these to the monitoring script.

```zsh
pid_string="$(pgrep -g 18787 | awk '{if( NR == 1 ) string=$0;
                                     else string=string "," $0}
                                     END {print string}')"
monitor_pid.mash -bv -f 1800 -o "logs (nohup)/monitor_pid $(getTimestamp).log" -p "$pid_string"
```
