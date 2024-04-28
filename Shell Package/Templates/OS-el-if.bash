if [[ $OSTYPE == "darwin"* ]]; then
    :
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    :
else
    echo "Unsupported operating system."
    exit 1
fi
