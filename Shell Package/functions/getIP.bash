#!/bin/bash

HauriIP() {
    # h/t to https://stackoverflow.com/a/13322667/5478086
    read -r _{,} gateway _ iface _ ip _ < <(ip r g 1.0.0.0)
    _="$gateway"
    _="$iface"
    echo "$ip"
}

getIP() {
    # Public IP methods
    # Public IP methods: Method 1 (for macOS and Linux)
    publicip1=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com)

    # Public IP methods: Method 2 (for macOS and Linux)
    publicip2=$(curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g')

    # Private IP methods: OS-specific
    if [[ $OSTYPE == "darwin"* ]]; then
        # Method 1
        privateip1=$(ipconfig getifaddr "$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')")
        # Method 2
        privateip2=$(ifconfig -l | xargs -n1 ipconfig getifaddr)
    elif [[ $OSTYPE == "linux-gnu"* ]]; then
        # Method 1
        privateip1=$(HauriIP)
        # Method 2
        privateip2=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
        # Method 3
        privateip3=$(hostname -I)
    else
        echo "Unsupported operating system."
        exit 1
    fi

    # Construct results message
    if [[ $OSTYPE == "darwin"* ]]; then
        :
        results_message="$(cat <<RESULTS
Showing IP address results for your machine, "$(hostname)":
Public IP 1: $publicip1
Public IP 2: $publicip2
Private IP 1: $privateip1
Private IP 2: $privateip2
RESULTS
)"
    elif [[ $OSTYPE == "linux-gnu"* ]]; then
        results_message="$(cat <<RESULTS
Showing IP address results for your machine, "$(hostname)":
Public IP 1: $publicip1
Public IP 2: $publicip2
Private IP 1: $privateip1
Private IP 2: $privateip2
Private IP 3: $privateip3
RESULTS
)"
    else
        echo "Unsupported operating system."
        exit 1
    fi

    # Print results
    echo "$results_message"
}
