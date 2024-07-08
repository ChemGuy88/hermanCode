
getPgrep_Linux() {
    if [ -z "$1" ] && [ -z "$2" ];
    then
        echo "You must provide both the user and keyword arguments for getPgrep"
        return 1
    fi
    pgrep -U "$1" -f "$2" | xargs --no-run-if-empty ps f -o lstart -o "%p %r %y %x %a" --sort +pid p
}

getPgrep_macOS() {
    if [ -z "$1" ] && [ -z "$2" ];
    then
        echo "You must provide both the user and keyword arguments for getPgrep"
        return 1
    fi
    pgrep -U "$1" -f "$2" | xargs --no-run-if-empty ps -o lstart -o pid -o pgid -o ppid -o tty -o time -o command
}

if [[ $OSTYPE == "darwin"* ]]; then
    alias getPgrep="getPgrep_macOS"
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    alias getPgrep="getPgrep_Linux"
else
    echo "Unsupported operating system."
    exit 1
fi
