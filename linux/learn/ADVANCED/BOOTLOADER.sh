#!/bin/bash
# legacy BIOS edit /etc/default/grub before generating a new grub configuration file
# Generate grup config
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
# for efi systems
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

# After configuring grub you can install it on specific disk
lsblk
sudo grub2-install /dev/vda > /home/bob/grub.txt 2>&1