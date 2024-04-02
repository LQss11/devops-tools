# add user to sudo group
sudo gpasswd -a trinity wheel
# Who can use sudo 
# Sudo file /etc/sudoers
sudo visudo

# Syntax:
# user/group 
# host= 
# (run_as_user)
# command_list

# Allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
# For user trinity
trinity ALL=(ALL:ALL) ALL
# Allow to run sudo commands as user john
trinity ALL=(aaron,john:ALL) ALL
sudo -u john ls /home/john
# Allow to run sudo only specific commands
trinity ALL=(ALL:ALL) /bin/ls, /bin/stat

# Do not as for password
trinity ALL= NOPASSWD:ALL