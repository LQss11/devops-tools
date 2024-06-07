#!/bin/bash

# Log function for better formatting
log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')]: $1"
}
log "Setting up ssh.."
mkdir -p /root/.ssh
cat >/root/.ssh/config<< EOF
Host *
    StrictHostKeyChecking accept-new
EOF
/usr/sbin/sshd -D -e &
log "Starting Docker daemon"
dockerd-entrypoint.sh
# nmap -sn 172.10.10.0/24 | grep manager 
# if manager 1 does not exist  you know that you are manager 1
# run docker swarm init and joing all nodes using ssh root:root