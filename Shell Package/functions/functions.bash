
getTimestamp() {
    date "+%Y-%m-%d %H-%M-%S"
}

getDirectorySizes () {
    if [[ -z "$1" ]]; then
        return
    else
        du -csh "$1"/*/
    fi
}

listpath () {
     awk -F : '{
     for (i = 0; ++i <= NF;)
          print "Path", i,":", $i
     }' <<<"$1"
     # Usage:
     # listpath $PATH
}

