# Managing Packages
# Install (v for verbose and h for hash)
rpm -ivh somepackage.rpm
dpkg -i somepackage.deb
# Uninstall
rpm -e somepackage.rpm
dpkg -r somepackage.deb
# Update
rpm -Uvh somepackage.rpm
# Verify
rpm -Vf somepackage.rpm
dpkg -p somepackage.deb
# Get installed packages
rpm -qa

# Software repo
/etc/yum.repos.d
/etc/apt/sources.list
# Add 3rd party repo
/etc/yum.repos.d/nginx.repo
/etc/apt/sources.list

# List repos 
yum repolist
# Get info about the repo related to tool
yum provides scp
# Edit sources
apt edit-sources

# Other apt commands
apt remove | apt search telnet

# get info about installed package
apt show lobnginx-mod-stream