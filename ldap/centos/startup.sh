#!/bin/bash

# Wait a sec for OpenLDAP to start
sleep 1

# Run sssd
rm -f /var/run/sssd.pid
sssd

# Allow LDAP users to authenticate
sed -i '6iauth        sufficient    pam_sss.so use_first_pass' /etc/pam.d/system-auth
sed -i '6iauth        sufficient    pam_sss.so use_first_pass' /etc/pam.d/password-auth

# ... continue on with whatever the container was going to do
ls
bash