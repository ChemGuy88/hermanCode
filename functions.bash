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

