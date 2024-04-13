# public server establish communication between internet and internal network 

# Port forward config (/etc/sysctl.config is risky cuz updates might reset config)
/etc/sysctl.d/99-sysctl.config

# Enable port forwarding
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.d/99-sysctl.config

check changes 
sudo sysctl -a | grep forward 

# Linux manages fw redirect and nat by a kernet framework called netfilter framework 
# nft could be used as command but iptables is easier to use and implement then translated to nft
# NAT example configuration 
iptables -t nat -A PREROUTING -i enp1s0 -s 10.0.0.0/24 -p tcp -dport 8080 -j DNAT --to-destination 192.168.0.5:80

# After receiving package sending it back will create a conflict 
# where we are expected to send the packet with the public server ip 
# not current server so to fix that we should create another rule
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp6s0 -j MASQUERADE

# Check nft rules
nft list ruleset
# List nat rules
iptables --list-rules --table nat
# Empty rules
iptables --flush --table nat

# To make rules permanent on sys reboot
apt install iptables-persistent
# Save with this command
netfilter-persistent save