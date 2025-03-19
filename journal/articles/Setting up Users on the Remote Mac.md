# Setting up Remote Users on the Remote Mac

We assume you are connected to the Remote Mac via SSH. Ideally this should be implemented as a shell script.

Software to install in order of dependence
1. Xcode (needed for git)
   1. Check if installed.
   2. If not installed, download the Xcode installer locally, then use `scp` to transfer it to the Remote Mac
2. [miniconda](https://www.anaconda.com/docs/getting-started/miniconda/install#quickstart-install-instruction) (needed for `midas`  package)
   1. Use x86, not ARM version of shell cript.
```shell
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
```
   2. `conda init`
3. Install python and respective environments
4. Herman's Code (needed for `midas`  package)
5. Install brew (optional?)
