# Pam manual
man pam.conf
# Get pam modules (man pam then click tab twice)
man pam
# Pluggable authentication module (PAM)
# contains login stuff
ls /etc/pam.d/
# Update su behaviour
vi /etc/pam.d/su
# 1. What type of auth module to use (account, auth, password, session)
# 2. Control field (required, requisite, optional, sufficient, include, substack)
# 3. Modules .so use man pam_wheel for example to get more information about module and its subsequent configs 
auth    sufficient   pam_wheel.so trust use_uid  

# example 
echo "auth    required       pam_listfile.so onerr=succeed  item=user  sense=deny  file=/etc/ssh/deniedusers" >>/etc/pam.d/ssd
echo "root" >>/etc/ssh/deniedusers
