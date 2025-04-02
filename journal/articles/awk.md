# `awk`

Some of my own examples for using `awk`.

# Example 1

| Environment Key             | Value        |
| --------------------------- | ------------ |
| OS                          | macOS 15.3.2 |
| AWK(1) Version (from `man`) | 2020-11-24   |

```zsh
echo "1
2 3
4" | awk '{print "line " NR " of " ARGC 
":\t arg1: " $1 
"\t arg2: " $2 
"\t line length: " length }'
```

Returns

```text
1 of 1 : arg1: 1 arg2:  len: 1
2 of 1 : arg1: 2 arg2: 3 len: 3
3 of 1 : arg1: 4 arg2:  len: 1
```
