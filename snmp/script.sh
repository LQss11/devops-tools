#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
# Update package list and install required packages
sudo apt-get update
sudo apt install -y snmp snmpd

# SNMP configuration file
SNMP_CONF="/etc/snmp/snmpd.conf"

# Update SNMP configuration
# Change address to listen on all interfaces
sudo sed -i \
  -e 's/^agentaddress.*/agentaddress udp:161,udp6:[::1]:161/' \
  -e 's/^sysLocation.*/sysLocation    AWS/' \
  -e 's/^sysContact.*/sysContact     email@example.com/' \
  -e 's/^rocommunity  public.*/rocommunity  test/' \
  -e 's/^rocommunity6 public.*/rocommunity6 test/' \
  $SNMP_CONF

# Update snmp trap config
sudo cat >/etc/snmp/snmpd.conf.d/trap_config.conf <<EOF
trap2sink 10.0.1.101 test 162
authtrapenable 1
EOF

# Restart SNMP service
sudo systemctl restart snmpd
# send trap test
# snmptrap -v 2c -c test 10.0.1.101:162 "" 1.3.6.1.2.1.43.18.2.0.1