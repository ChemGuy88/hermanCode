if [[ $OSTYPE == "darwin"* ]]; then
    # macOS
    :
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # Linux
    :
else
    echo "Unsupported operating system."
    exit 1
fi
