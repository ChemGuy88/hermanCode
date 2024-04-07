listpath () {
     awk -F\: '{
     for (i = 0; ++i <= NF;)
          print "Path", i,":", $i
     }' <<<$1
}
# listpath $PATH
# listpath $PYTHONPATH

getTimestamp() {
    date "+%Y-%m-%d %H-%M-%S"
}

getDirectorySizes () {
    currentDirectory=$(pwd)
    cd $1
    du -sh */
    cd "$currentDirectory"
}

getPgrep() {
    pgrep -U $1 -f $2 | xargs --no-run-if-empty ps
}
