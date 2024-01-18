# Networks
/etc/hosts # Set host 192.1.1.44
# You can use: nameserver 191.1.1.222 
# also could resolve domain for example: search mycompany.com to resolve anything under it
/etc/resolv.conf 
/etc/nsswitch.conf # Order tf resolv hosts: files dns
# Get info about dns
nslookup www.google.com
dig www.google.com

# More Networking
ip link # get info about interface
# Bring interface up
ip link set dev eth0 up
# Switch is used to connct vms on same network like 192.168.1.0 
ip addr
ip addr add 192.168.1.10/24 dev eth0 # Assign ip addr to vm (dev used to specify the network interface)
# Router used to connect 2 vms from different networks (it connects networks  from diff switches)
ip route add 192.168.2.0/24 via 192.168.1.1 # ip route or ip r are the same
# default = 0.0.0.0 = * 192.168.1.1 is the gateway and default is the target
ip route add default via 192.168.1.1
# Delete default route 
sudo ip r del default

# Troubleshhoting
# Check state of interface 
ip link
# Check target (check if dns server can look for the dns ip)
nslookup www.mydomainexamples.com
# Ping or telnet or traceroute
ping www.mydomainexamples.com
# Check if server is running on port 80
netstat -atulpn | grep -iw :8080

# Check for /etc/netplan/00-installer-config.yaml and netplan
