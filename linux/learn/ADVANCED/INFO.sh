man man
# Get commands that might control directories
apropos director
sudo mandb

# Soft and hard links (inode is the unique id of files)
# Get info about file
stat /my/file.txt
# Create a link (links share same permissions and cannot be shared between multiple filesystems)
# hard links points to inode
ln /my/file.txt
# soft links point to file path
ln -s /my/file.txt

# C