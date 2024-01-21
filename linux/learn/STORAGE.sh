# Storage commands
lsblk # Get info about disk blocks
ls -l /dev/ | grep "^b" # Get block filetypes
fdisk -l /dev/sda # Get info about disk
gdisk /dev/sdb # Create partition from disk sdb
# n key for size and partition number w for partition table gpt/mbr
# Delete partition
sudo unmount /dev/vdb1
sudo fdisk /dev/vdb # p -> d -> w  # verify delete and save

# Filesystems
df -h
# Get type of fs
blkid /dev/vdc
# Create a filesystem
sudo mkfs.ext4 /dev/vdb
sudo mkdir /mnt/data
sudo  mount /dev/vdb /mnt/data
# Persist partition 
vi /etc/fstab
/dev/vdb        /mnt/data       ext4    rw                       0       0