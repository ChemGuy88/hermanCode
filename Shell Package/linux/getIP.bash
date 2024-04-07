#!/bin/bash
# This script prints the public and private IP address of the current machine using two methods for each IP address type.

# Public IP method 1
publicip1=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com)
# Public IP method 2
publicip2=$(curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g')

# >>> Linux implementations >>>
HauriIP() {
    # h/t to https://stackoverflow.com/a/13322667/5478086
    read -r _{,} gateway _ iface _ ip _ < <(ip r g 1.0.0.0)
    echo "$ip"
}

# Private IP method 1
privateip1=$(HauriIP)
# Private IP method 2
privateip2=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
# Private IP method 3
privateip3=$(hostname -I)

# <<< Linux implementations <<<

echo "Showing IP address results for your machine, $(hostname):"
echo "Public IP 1: $publicip1"
echo "Public IP 2: $publicip2"
echo "Private IP 1: $privateip1"
echo "Private IP 2: $privateip2"
echo "Private IP 3: $privateip3"