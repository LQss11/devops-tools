#!/bin/bash
# Get useradd defaults
useradd -D
# Get all variabels to be used as defaults 
cat /etc/login.defs
# set password
passwd john
# NOTE: default files to be copied under /home/john will be from /etc/skel
useradd john
useradd -s /bin/bash -d /home/johnXXX -u 1002 john 
# ls and get info about id of user and group instead if names of owners and groups
ls /ln /home/john
# Create system account for daemon for example like db (no home generated)
useradd --system myappuser

# Modify users
# Change homedir 
usermod -d /home/john2 -m john
usermod -l newjohnname john
usermod -s /bin/sh john

# Lock user 
usermod -L john
# expire account
usermod -e "2025-01-22" john
# remove expire account
usermod -e "" john

# Password expiration every 30 days
chage -M 30 john
# get info
chage --list john
# expire password and force user to change it
sudo chage --lastday 0 john


# delete user
userdel john
# delete his home dir too
userdel -r john