#!/bin/bash

# Log function for printing important messages with timestamps
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Prompt the user for a network CIDR, with a default value
read -p "Enter network CIDR (default is 10.10.10.0/24): " network_cidr
# Set default if no input is given
network_cidr=${network_cidr:-10.10.10.0/24}

# Prompt the user for a comma-separated list of usernames
read -p "Enter comma-separated list of usernames (e.g., root,user1): " user_list

# Convert comma-separated list to an array
IFS=',' read -r -a users <<< "$user_list"

# Run the nmap command to find all IP addresses with port 22 open
log "Starting scan for network CIDR: $network_cidr"
open_hosts=$(nmap -p 22 --open -n $network_cidr -oG - | awk '/22\/open/{print $2}')
log "Scan completed. Found open hosts: $open_hosts"

# Function to test SSH connection
test_ssh() {
  local ip=$1
  local user=$2
  if ssh -o BatchMode=yes -o ConnectTimeout=5 $user@$ip "exit" 2>/dev/null; then
    log "Host with authorized keys found for user $user: $ip"
  fi
}

# Export the function so it can be used by parallel processes
export -f test_ssh
export -f log

# Loop through each detected host and user, running tests in parallel
for ip in $open_hosts; do
  for user in "${users[@]}"; do
    test_ssh $ip $user &
  done
done

# Wait for all background processes to finish
wait

log "SSH key check completed for all users and hosts."
