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