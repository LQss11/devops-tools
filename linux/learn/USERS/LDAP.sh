# Lightweight Directory Access Protocol
sudo apt-get update && sudo apt-get install libnss-ldapd -y
# Update ldap config
sudo cat /etc/nslcd.conf
# after configuring check added ldap
cat /etc/nsswitch.conf 

# get only users from ldap
getent passwd --service ldap
getent group  --service ldap

# In case user home directory does not exist for users from ldap
pam-auth-update
