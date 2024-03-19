# Check if selinux enabled 
getenforce
# Get selinux permissions
ls -Z
#                            .------------- user
#                            |           .---------- role
#                            |           |         .------- type
#                            |           |         |       .---- level
#                            |           |         |       |
# -rw-r--r--. root root unconfined_u:object_r:admin_home_t:s0 file.txt

# Example
# | Selinux user | roles                                  |
# | ------------ | -------------------------------------- |
# | developer_u  | developer_r, docker_r                  |
# | guest_u      | guest_r                                |
# | root         | staff_r,sysadm_r,system_r,unconfined_r |

# for processes we can also see this
ps axZ

# debug example the process
ps auxZ | grep sshd
ls -Z $(which sshd)
# system_u:system_r:sshd_t:s0-s0:c0.c1023 1206 ? Ss     0:04 /usr/sbin/sshd -D
# -rwxr-xr-x. root root system_u:object_r:sshd_exec_t:s0 /usr/sbin/sshd

# get current user selinux access
id -Z
# SELinux user mapping
sudo semanage login -l
# Selinux roles
sudo semanage user -l

