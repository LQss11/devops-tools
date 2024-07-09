#!/bin/bash
# Update root password
su root
passwd
# Make user with no sudo password everytime
echo "lqss ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#### Netowrk

## Get info about network range 
# sudo apt-get install -y ipcalc && ipcalc 172.19.224.0/20 
## Use apr-scan to get all ip addresses existing in network
# sudo apt install -y arp-scan && arp-scan arp-scan --localnet
cat >/etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 172.19.231.200/20
      routes:
        - to: 0.0.0.0/0
          via: 172.19.224.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

chmod 600 /etc/netplan/01-netcfg.yaml

netplan apply


#### Storage (make sure to update etc fstab to persist)
# Create new partition you must see sth like this (Created a new partition 4 of type 'Linux filesystem' and of size 1.9 GiB.)
echo -e "n\n4\n\n+2GB\nw\n" | fdisk /dev/sda
# Create physical volume and add it to volume group (pvdisplay / vgdisplay)
pvcreate /dev/sda4 && vgextend ubuntu-vg /dev/sda4
# Create 2GB logical volume from physical volume group (or use the rest: lvcreate -l 100%FREE -n mydata_lv ubuntu-vg) 
# and format it
lvcreate -L 2G -n mydata_lv ubuntu-vg && mkfs.ext4 /dev/ubuntu-vg/mydata_lv

# This utilizes the rest  on exisitng volume
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv

# Mount dirs
mkdir /mnt/example
mount /dev/ubuntu-vg/example_lv /mnt/example

