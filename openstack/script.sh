#!/bin/bash


sudo mkdir -p /opt/stack
cd /opt/stack
sudo apt-get update && apt-get install git
sudo git clone https://git.openstack.org/openstack-dev/devstack devstack
cd devstack
sudo chown $(id -un):$(id -gn) -R /opt/stack
git branch --all
git checkout stable/ussuri

cp samples/local.conf .

cat >>local.conf<<EOF
HOST_IP=$(hostname -i)
DEST=/opt/stack
USE_PYTHON3=True
FORCE=yes
EOF

sed -i -e "s#ADMIN_PASSWORD=.*#ADMIN_PASSWORD=secret#g" local.conf

./stack