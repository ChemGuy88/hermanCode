#!/usr/bin/env bash

# Check if a script is being run as the super-user "SUDO".

# This needs to be run like below
# sudo /usr/bin/env bash -c "source \"Shell Package/Examples/Check if Running as SUDO.bash\""
# H/t to "https://stackoverflow.com/a/30100503/5478086"

echo "\$_ is: \"$_\""
echo "\$? is \"$?\""
echo "Your 0th argument: \"$0\""
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or using \`sudo\`."
    exit 1
fi

if [ "$0" == "-bash" ] || [ "$0" == "bash" ]; then
    :
else
    echo "This script must be run using \"source\" or \".\""
    exit 1
fi
