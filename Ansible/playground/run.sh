#!/bin/sh
ssh-keygen -t rsa -b 2048 -C "" -f ~/.ssh/id_rsa -N "" 
for host in $(cat hosts | tail -n +2); do
ssh-keyscan $host >> ~/.ssh/known_hosts
done


