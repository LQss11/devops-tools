# Commands to execute in an azure vm for test
```sh
$openStackControllerIP = "172.178.55.202"
sudo tee /etc/hosts << EOT
$(hostname -i) $(hostname)
EOT
sudo ip tuntap add mode tap br_ex_port
sudo ip link set dev br_ex_port up

sudo apt-get update && sudo apt install -y python3-dev libffi-dev gcc libssl-dev python3-venv net-tools
sudo apt install -y nfs-kernel-server
openStackControllerIP="172.178.55.202"
CINDER_NFS_HOST=$openStackControllerIP
CINDER_NFS_ACCESS=$CINDER_NFS_HOST
sudo mkdir /kolla_nfs
```