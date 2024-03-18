curl "https://download.docker.com/linux/ubuntu/gpg" -o docker.key
# generate the gpg (docker.key.gpg) file to verify docker version integrity
gpg --dearmor docker.key

# move gpg to verified package sigs dir
mv docker.key.gpg /etc/apt/keyrings/
# or 
mv docker.key.gpg /usr/share/keyrings/

# create new list
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.key.gpg] \
    https://download.docker.com/linux/ubuntu jammy stable" > \
    /etc/apt/sources.list.d/docker.list

# simpler way 
# result: deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu bionic stable
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable"


# another way (does everything we did above)
sudo add-apt-repository ppa:graphics-driver/ppa

# remove ppa
sudo add-apt-repository --remove ppa:graphics-driver/ppa