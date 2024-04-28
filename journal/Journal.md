# Journal

## Accessing your home computer remotely

On a local Mac you can access your home Mac remotely by mounting it. Below are the steps

1. Setup SSH connection with SSH keys to your remote Mac
2. Install the following as admin:
   1.  [OSXFUSE](http://osxfuse.github.io/)
   2.  [SSHFS](http://osxfuse.github.io/)
3.  Create a local folder to access your remote filestystem
```bash
mkdir /tmp/sshfs
```
4. Mount the remote file system
```bash
sshfs username@remote:$REMOTE_DIRECTORY $MOUNT_POINT
```
where `$REMOTE_DIRECTORY` is the path of the remote directory you want to mount and `$MOUNT_POINT` is where you want to mount it to.

To un-mount the file system simply do
```bash
diskutil umount force /mount/point
```

## Notes - Bash

### Calculate the file size of files found using `find`

```bash
find "$PATH_ARGUMENT" -exec du -ch {} + > output.log
```

The interesting bit here is `-exec COMMAND {} +`. In our case, `COMMAND` is `du`, but more importantly we are using the `{} +` form of `-exec`, as opposed to the more common `{} \;` form. The latter passes each file found with `find` to `COMMAND`, iteratively, but the form we use passes all the files together. This allows us to calculate the sum of the file sizes.

### `nohup`

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

## Best Practice for Data Science

### Set environment variables
Set environment variables in `%CONDA_PREFIX%/etc/conda`. See the [docs](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

### Set IPython configuration for each Anaconda Virtual Environment
Create `ipython_configuration.py` in `%CONDA_PREFIX%/etc/ipython`. See [docs](https://ipython.readthedocs.io/en/stable/config/intro.html#systemwide-configuration)
Then change the `IPYTHONDIR` environment variable via Anaconda.

### Example (Windows)

Your Anaconda `env_vars.bat` file will look like this:

```bash
set SECRET_VARIABLE_1=secretValue1
set SECRET_VARIABLE_2=secretValue2
set SECRET_PATH=\\networkFolder\userName\folder1
set IPYTHONDIR=%CONDA_PREFIX%\etc\ipython
pushd \\networkFolder\userName\folder1 #&@REM This is only necessary if your projectDirectory is a networkFolder
cd \\networkFolder\userName\folder1
```