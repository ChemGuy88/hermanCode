################################################################################
### Gate-keeping ###############################################################
################################################################################

RED=$'\e[0;31m'
GRN=$'\e[0;32m'
NC=$'\e[0m'

TheWorldIsFlat=false  # Change this to `true` to gate-keep the gate keeper.
if [[ "$TheWorldIsFlat" = true ]]; then
    read -p "Do you want to ${RED}continue${NC} loading BASH run commands? [Y/n]: " confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        :
        echo "${GRN}Continuing${NC} to load BASH RC."
    else
        echo "${RED}Aborting${NC} the load of BASH RC."
        return
    fi
fi

# Continue sourcing file if we're logging in interactively. Otherwise, return 
# early. This is to prevent polluting the shell with un-needed output.
# This is necessary when running `scp`.
# See https://unix.stackexchange.com/a/505642/399435

if [[ $- == *i*  ]]; then
    :  # Continue reading BASH RC
    echo "Detected ${GRN}interactive${NC} mode. ${GRN}Continuing${NC} to load BASH RC."
else
    # echo "Detected ${RED}non-interactive${NC} mode. ${RED}Aborting${NC} the load of BASH RC."
    return
fi

################################################################################
### Constants: Define values ###################################################
################################################################################

export BASH_SILENCE_DEPRECATION_WARNING=1

export PSEUDOHOME="/data/herman"

################################################################################
### Constants: Modify constants ################################################
################################################################################

# Modify `PATH`
PATH="/home/herman/Documents:\
/home/herman/.hermanCode:\
${PATH}"

# Modify `PYTHONPATH`
PYTHONPATH="/data/herman/Documents/GitHub/drapi-lemur/src/drapi:\
${PYTHONPATH}"
export PYTHONPATH

################################################################################
### Custom Prompts #############################################################
################################################################################

CYAN="\[$(tput setaf 4)\]"
WINERED="\[$(tput setaf 88)\]"
ATOMGREEN="\[$(tput setaf 114)\]"
RESET="\[$(tput sgr0)\]"
export PS1="(${CONDA_DEFAULT_ENV}) \@ [\#] ${CYAN}\W${RESET}${ATOMGREEN} -->${RESET} "

################################################################################
### Load more configurations ###################################################
################################################################################

if [ -f ~/.hermanCode/limericks_in.bash ]; then
    source ~/.hermanCode/limericks_in.bash
fi

################################################################################
### Functions ##################################################################
################################################################################

source "/home/herman/.hermanCode/functions.bash"

################################################################################
### Shortcuts ##################################################################
################################################################################

# Aliases
alias vim="vi -S ~/.vim/.vimrc"
alias cddr='cd "/data/herman/mnt/ufhsd/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Bian/IRB201902162"'
alias cddr='cd "/data/herman/mnt/ufhsd/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Liu/IRB202300703"'
alias cddr='cd "/data/herman/Projects/IRB202300703"'
alias cddr='cd "/data/herman/mnt/ufhsd/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Bian/IRB202003281"'
alias mountufhsd='sudo /sbin/mount.cifs //ahcdfs.ahc.ufl.edu/files /data/herman/mnt/ufhsd -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0'
alias mountufhsd='sudo /sbin/mount.cifs //ahcdfs.ahc.ufl.edu/files "/data/herman/Mounted Drives/UF Health Shared Drive" -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0'

# Functions
cdwork() {
    conda activate idr-bian
    echo "\`cdwork\`: Going to data request directory"
    cddr
}

cdherman(){
    conda activate just-selenium
    echo "\`cdherman\`: Going to project directory"
    cdproject
}

# Conveniences
cdwork
getPgrep ".py"
echo
df -h /data/herman/Projects
echo
du -sh /data/herman/Projects  # for el in /data/herman; if el not "mnt"; du -sh el