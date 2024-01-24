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


# NFS
# To setup we need to configure /etc/exports
/my/path 172.16.1.99  172.16.1.100 172.16.1.200

# Once configured to export it from server
exportft -a # will check exports in /etc/exports
exportfs -o 172.16.1.44:/other/path # Export manually

# To mount from client (specify the nfs server ip and path in nfs and path in mnt)
mount 172.16.1.14:/my/path /mnt/nfsmypath

# LVM or managing volumes
apt-get install lvm2 -y
pvcreate /dev/sdb
vgcreate my_volume_group /dev/sdb
pvdisplay
vgdisplay

# Create logical volume
lvcreate -L 1G -n vol1 my_volume_group
lvdisplay
lvs
mkfs.ext4 /dev/my_volume_group/vol1 # Also thiscould be referred as /dev/mapper/my_volume_group-vol1
mount -t ext4 /dev/my_volume_group/vol1 /mnt/vol1
# Resize volume
vgs # Check if free space is available
lvresize -L +2G -n /dev/my_volume_group/vol1 # Apply changes to logical volume (fs will not be updated yet)
resize2fs /dev/my_volume_group/vol1 # Apply changes to file system

# Verify changes
df -hP /mnt/vol1