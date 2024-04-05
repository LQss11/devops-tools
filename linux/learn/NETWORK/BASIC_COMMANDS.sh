# Check open ports (ss is newer vesion of netstat)
ss -tulpn
# netplan is one of the most commonly used networking configuration tools
# config file under /etc/netplan/00-installer-config.yaml
netplan get
man netplan
ls /usr/share/doc/netplan/examples/
# Apply changes 
sudo netplan apply
# Test before apply
sudo netplan try --timeout 300

# Networking devices (interfaces)
ip link
# Examples of interfaces
lo: loopback interface -> used by the system when it needs to connect to itself (example app connects to a db on same system)
enp0s3: real ethernet card

# Show more details about interfaces addresses (-c for readability)
ip -c a

# Set interface device UP or DOWN
sudo ip link set dev enp0s8 up

# Set address to interface
sudo ip a add 192.168.5.55/24 dev enp0s8
sudo ip a add 2001:db8:3333:4444:5555:6666:7777:8888/64 dev enp0s8
# Delete address
sudo ip a delete 2001:db8:3333:4444:5555:6666:7777:8888/64 dev enp0s8


# Check routes to other networks 
ip route

# Troubleshoot dns (systemd-resolve --status in old versions)
resolvectl status
# Update and apply global DNS
sed -i "s/#DNS=.*/DNS=8.8.8.8 9.9.9.9/g" /etc/systemd/resolved.conf
systemctl restart systemd-resolved.service
resolvectl dns


