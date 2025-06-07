#!/bin/bash

# Check if host argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <host>"
    exit 1
fi

echo "And off we go..."
echo

# First scan to find open ports
echo "Performing initial port scan..."
open_ports=$(nmap -Pn -p- --min-rate=1000 "$1" | grep "open" | awk -F'/' '{print $1}' | tr '\n' ',' | sed 's/,$//')

if [ -z "$open_ports" ]; then
    echo "No open ports found"
    exit 1
fi

# Second scan with detailed information
echo "Performing detailed scan on ports: $open_ports"
nmap -sC -sV -T5 -Pn -p"$open_ports" "$1" | tee -a "nmap_$1.txt" 