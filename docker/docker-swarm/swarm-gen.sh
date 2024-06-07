#!/bin/bash

# Run the nmap command and search for the term 'swarm-manager-1'
result=$(nmap -sn 172.10.10.0/24 | grep swarm-manager-1)

# Check if the result is empty or not
if [ -z "$result" ]; then
  echo "I am swarm-manager-1 proceeding"
else
  echo "I am not swarm-manager-1"
fi
