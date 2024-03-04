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

listpath () {
     awk -F\: '{
     for (i = 0; ++i <= NF;)
          print "Path", i,":", $i
     }' <<<$1
}
# listpath $PATH
# listpath $PYTHONPATH

timeStamp() {
date "+%Y-%m-%d %H-%M-%S"
}

getDirectorySizes () {
    currentDirectory=$(pwd)
    cd $1
    du -sh */
    cd "$currentDirectory"
}

getPgrep() {
    pgrep -U herman -f $1 | xargs --no-run-if-empty ps fp
}

################################################################################
### Shortcuts ##################################################################
################################################################################

# Aliases
alias vim="vi -S ~/.vim/.vimrc"
alias cddr='cd "/data/herman/mnt/ufhsd/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Bian/IRB201902162"'
alias cddr='cd "/data/herman/mnt/ufhsd/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Bian/IRB202003281"'
alias cddr='cd "/data/herman/mnt/ufhsd/SHANDS/SHARE/DSS/IDR Data Requests/ACTIVE RDRs/Liu/IRB202300703"'
alias cddr='cd "/data/herman/Projects/IRB202300703"'
alias cdproject='cd "/data/herman/Documents/GitHub/Company Ratings Scraper"'
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
