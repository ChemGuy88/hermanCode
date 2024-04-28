#!/bin/bash

publicip1=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com)
privateip1=$(ipconfig getifaddr "$(networksetup -listallhardwarereports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')")
privateip2=$(ifconfig -l | xargs -n1 ipconfig getifaddr)

echo "SHowing IP address results for your machine, $(hostname):"
echo "Public IP 1: $publicip1"
echo "Private IP 1: $privateip1"
echo "Private IP 2: $privateip2"