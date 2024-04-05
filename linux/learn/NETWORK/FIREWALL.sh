# ufw disabled by default if enabled nothing will come in or out as trafic we need rules
# order of rules is important so if allow is before deny, deny will be ignored
ufw status verbose
ufw status numbered

ufw allow ssh
ufw allow 22
ufw allow 22 from 192.168.1.60 to any port 22
ufw allow 22 from 192.168.1.0/24 to any port 22
ufw allow 22 from 192.168.2.0/24
ufw deny 22 from 192.168.3.0/24
# Outbound: Stop internet trafic from interface
ufw deny out on enp0s3 to 8.8.8.8
# Inbound
ufw deny in on enp0s3 from 192.168.1.60 to 192.168.1.81 port 80 proto tcp

# Insert on a specific number order
ufw insert 3 deny from 10.11.22.100
# to delete a rule list with ufw status verbose then get id and run this
ufw delete 1
# another way to delete a created rule
ufw delete allow 22
# enable firewall
ufw enable