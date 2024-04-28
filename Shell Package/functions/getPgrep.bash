
getPgrep_Linux() {
    pgrep -U "$1" -f "$2" | xargs --no-run-if-empty ps f -o lstart -o "%p %r %y %x %a" --sort +pid p
}

getPgrep_macOS() {
    pgrep -U "$1" -f "$2" | xargs --no-run-if-empty ps -o lstart -o pid -o pgid -o tty -o time -o command
}

if [[ $OSTYPE == "darwin"* ]]; then
    alias getPgrep="getPgrep_macOS"
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    alias getPgrep="getPgrep_Linux"
else
    echo "Unsupported operating system."
    exit 1
fi

