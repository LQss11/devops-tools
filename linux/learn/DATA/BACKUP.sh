#!/bin/bash

# One of the most common tools is rsync but in target ssh daemon is required
# Rsync if ran next time will only copy files that has been changed
rsync -a Pictures/ user@host:/home/user/Pictures/
# The oppisite
rsync -a user@host:/home/user/Pictures Pictures/
# rsync locallly
rsync -a Pictures/ /Backups/Pictures/


# Disk imaging backup disk image
sudo dd if=/dev/vda of=diskimage.raw bs=1M status=progress
# Disk imaging restore just revers if and of (input and output file)
sudo dd if=diskimage.raw of=/dev/vda bs=1M status=progress