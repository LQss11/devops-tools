#!/bin/bash
# create a journal 
echo "hello world" | systemd-cat --identifier="some_logs"
# Look for some_logs in journalctl 
# mars 15 12:04:04 hostname some_logs[1234]: hello world
journalctl -e 

# Journalctl
journalctl -b 
journalctl -u docker.service

# Get information about process logs
sudo journalctl --unit=sshd.service -n 20 --no-pager

# Get system errors 
sudo journalctl -p err