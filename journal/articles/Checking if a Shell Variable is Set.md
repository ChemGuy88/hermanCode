# Checking if a Shell Variable is Set

Currently in the Shell package, I have tests of the form

```zsh
if [ -z "$VARIABLE" ]
```

and

```zsh
if [ -z "${VARIABLE+x}" ]
```

A search of the repository revealed that all queries for `if [ -z` are for the former type of test.

Today I read that the POSIX form of testing if a variable is set is

```shell
if [ -n "${VARIABLE+x}" ]
```

Conversely, the test to see if a variable is *unset* would be

```shell
if [ -z "${VARIABLE+x}" ]
```

More interesting is its explanation from the [*Unix & Linux StackExchange*](https://unix.stackexchange.com/a/755682/399435).
