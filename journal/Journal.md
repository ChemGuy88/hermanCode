# Journal

## Notes - Bash

To execute a command with `nohup` and have its "stdout" routed to a file use

```bash
nohup sh COMMAND ARGUMENT &> FILENAME &
```

Where `COMMAND` is the command, `ARGUMENT` is the command argument, and `FILENAME` is the file to where stdout is being redirected.

A more elaborate example is

```bash
nohup sh scriptForLoop.sh 12345 &> "$(timeStamp).out"&echo $(timeStamp)
```

And a practical, frequently used one is

```bash
nohup python script.py &> "$(timeStamp).out"&echo $(timeStamp)
```


## Notes - Anaconda

### Export manually (explicitely) installe dpackages[^1](https://stackoverflow.com/questions/62719108/is-there-a-way-in-conda-to-list-only-explicitly-installed-packages-without-the-p)

```shell
conda env export --from-history
```

Don't confuse it with 

```shell
conda list --explicit
```