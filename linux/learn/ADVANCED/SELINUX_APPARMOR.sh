# Check if selinux enabled 
getenforce
# Deactivate
setenforce 0
# Activate
setenforce 1
# Get selinux permissions
ls -Z
#                            .------------- user
#                            |           .---------- role
#                            |           |         .------- type
#                            |           |         |       .---- level
#                            |           |         |       |
# -rw-r--r--. root root unconfined_u:object_r:admin_home_t:s0 file.txt

# list all stuff
apt-get install -y setools
# User
seinfo -u 
# role
seinfo -r
# type
seinfo -t

# for processes we can also see this
ps axZ

# debug example the process
ps auxZ | grep sshd
ls -Z $(which sshd)
# extract selinux permissions directly
ps auxZ | grep sshd | awk '{print $1}' | head -1
ls -Z $(which sshd) | awk '{print $1}' | head -1
# system_u:system_r:sshd_t:s0-s0:c0.c1023 1206 ? Ss     0:04 /usr/sbin/sshd -D
# -rwxr-xr-x. root root system_u:object_r:sshd_exec_t:s0 /usr/sbin/sshd

# You can use -u -r -t -l
sudo chcon -t httpd_sys_content_t /var/index.html

# get current user selinux access
id -Z
# SELinux user mapping
sudo semanage login -l
# Selinux roles (identify users roles)
sudo semanage user -l



# APPARMOR
# By default Apparmor in Ubuntu and Selinux in centos and redhat

# Enabling selinux on it will cause issues since 2 security modules (selinux + apparmor)
# cannot run at the same time
# Enabling SELinux 
sudo systemctl stop apparmor.service
sudo systemctl disable apparmor.service
sudo apt install selinux-basics auditd

sestatus
sudu selinux activate
cat /etc/default/grub
sudo systemctl reboot

# to get info about security rules and all
sudo audit2why --all | less
# auditd inspects all activity when selinux in permissive mode 
# running this command after learning will generate all required rules for us
sudo audit2allow --all -M mymodule
# we can inspect what's going to happen before installing module
less mymodule.te
# Install package
semodule -i mymodule.pp
sudo setenforce 1 
sudo getenforce

# copy selinux contexts permissions
sudo chcon --reference=/var/log/syslog /var/log/auth.log
# restore all (type)
sudo restorecon -R /var/www/
# restore all (user role and type)
sudo restorecon -F -R /var/www/

# Other commands
sudo semanage fcontext --add --type var_log_t /var/www/10
sudo restorecon /var/www/10

# Get example of role for a whole directory
sudo semanage fcontext --list | grep "/var/www/uploads"
# Set a role for a directory using regex
sudo semanage fcontext --add --type nfs_t "nfs/shares(/.*)?"
mkdir -p /nfs/shares
sudo restorecon -R /nfs/
ls -Z

# Booleans
semanage boolean --list
sudo setsebool virt_use_nfs 1
sudo getsebool virt_use_nfs

# ports
sudo semanagae prot --list | grep ssh
sudo semanagae prot --add --type ssh_port_t --proto tcp 2222
sudo semanagae prot --delete --type ssh_port_t --proto tcp 2222

# setenforce 1 permanently
sed -i "s/SELINUX=permissive/SELINUX=enforcing/g" /etc/selinux/config