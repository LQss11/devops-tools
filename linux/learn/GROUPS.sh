# Wheel or SUDO group can do anything
# Primary group is the group for user by default when run commands or processes

# Commands
groupadd developers
# add user to group
gpasswd -a john developers
# delete user from group
gpasswd -d john developers
# check user groups
groups john

# change primary group
usermod -g developers john
# change secondary groups
usermod -G developers john

# rename group
groupmod -n programmers developers

# delete group (cannot delete group if it's primary for some user)
groupdel programmers

# Get users from groups
getent group docker | cut -d: -f4 | tr ',' '\n'