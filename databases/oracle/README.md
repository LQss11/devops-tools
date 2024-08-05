# Oracle
# Docker
```sh
docker pull container-registry.oracle.com/database/free:latest
```
# Host
In order to install oracle db you can simply download the oracle express edition by following this script:
```sh
#!/bin/bash

# Update system
sudo dnf update -y

# Setting Up Oracle Database
echo "### Setting Up Oracle Database ###"
sudo dnf -y install oracle-database-preinstall-21c

# Download Oracle Database 21
wget https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# Install Oracle Database 21
sudo dnf -y localinstall ./oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# Remove the downloaded RPM file
sudo rm -rf ./oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# Uncomment the following lines to configure the Oracle Database and set up the Oracle client

# Configure Oracle Database
yes "your-pass123" | sudo /etc/init.d/oracle-xe-21c configure

