# set env var on all logins
echo "MYVAR=EXAMPLE" >> /etc/environment
# Exec command on all logins
echo "welcome user" >>/etc/profile.d/welcome.sh
# Exec command on current user
echo "export myvar=myval" >>$HOME/.bashrc
# Execute without relogin
source $HOME/.bashrc