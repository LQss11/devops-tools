# how to share files between host machine and vm
in case host machine is `windows` and vm is `linux` follow through:
- create a directory in host
  1. right click + Click **Propreties**
  2. Click share
  3. Add permissions
- now in `linux` machine make sure you install **samba** and **cifs-utils** if needed:
```sh
sudo apt install cifs-utils
sudo mkdir -p /mnt/share
echo "//hostmachineIp/dirname /mnt/share/ cifs user=share,pass=share,file_share=0755,dir_share=0777 0 0" >>/etc/fstab
mount -a
# OR
sudo mount.cifs //hostmachineIp/dirname /mnt/share/ -o user=share,pass=share,file_share=0755,dir_share=0777
```
>you can follow either [1](https://markontech.com/linux/mount-a-network-shared-drive-on-linux/) or [2](https://ubuntuforums.org/showthread.php?t=288534)
>>If you don't know windows creds go to control pannel and check accounts, or if you are using email as default windows user then use your email credentials to mount the shared directory
```sh
# to unmount run
umount /mnt/share
```

# Mount with creds
You can also use credentials file to pass within the mount config
```sh
# <file system>             <dir>          <type> <options>                                                   <dump>  <pass>
//WIN_SHARE_IP/share_name  /mnt/win_share  cifs  credentials=/etc/win-credentials,file_mode=0755,dir_mode=0755 0       0
``` 
and in creds file **/etc/win-credentials**:
```sh
username=user
password=password
domain=domain
```
