# SNMP
Using this protocol (**Simple Network Management Protocol**) we can monitor our network easily by simply doing these steps
## Install snmpd (PORT 161 by default)
In order to allow a tool to collect info from all machines in a specific network we can use either

- **snmp v2**: using community string
- **snmpv v3**: using username and password


```sh
# We need to install the package responsible for the daemon and one for tools and libraries
sudo apt-get install snmp snmpd
# Verify snmp port
ss -tulpna | grep 161
```

once made sure that you installed it on machines you want to monitor you need to configure it as well like this:
```sh
# Change address to listen on all interfaces
sudo sed -i \
  -e 's/^agentaddress.*/agentaddress udp:161,udp6:[::1]:161/' \
  -e 's/^sysLocation.*/sysLocation    AWS/' \
  -e 's/^sysContact.*/sysContact     email@example.com/' \
  -e 's/^rocommunity  public.*/rocommunity  test default -V systemonly/' \
  -e 's/^rocommunity6 public.*/rocommunity6 test default -V systemonly/' \
  /etc/snmp/snmpd.conf
```

## SNMP traps (PORT 162 by default)
with an SNMP trap, an agent can send an unrequested message to the manager to notify about an important event.

You can add a speicifc snmp configuration to send traps:

### Server configuration
```sh
apt-get install -y snmptrapd
# check snmp trap daemon service (disabled by default make sure to start it if you want)
systemctl status snmptrapd
# This will start receiving udp packets on port 162
systemctl start snmptrapd
```
>`trapcommunity test` could be used to change the trap community string (defaults to snmp comstring) in snmp config
### Client configuration
```sh
trap2sink 10.0.1.101 test 162
authtrapenable 1
```
# Test SNMP
## SNMP
You can try to send hello world using snmp walk as a test example:
```sh
snmptrap -v 2c -c test 10.0.1.101:161 "" 1.3.6.1.2.1.43.18.2.0.1
```
## SNMP traps
You can try to send hello world using snmp trap as a test example:
```sh
snmptrap -v 2c -c test 10.0.1.101:162 "" 1.3.6.1.4.1.12345.1.0.1 0 s "hello world"
snmptrap -v 2c -c test 10.0.1.101:9162 '' .1.3.6.1.4.1.8072.2.3.0.1 .1.3.6.1.4.1.8072.2.3.2.1 s "Hello, World"
```

# References and examples
- [**Example snmp config**](https://gist.github.com/mingderwang/24cabb9735ff061181a8)
- [**SNMP Full config**](https://gist.github.com/skihero/970420)
- [**SNMP traps config**](http://www.net-snmp.org/wiki/index.php/TUT:snmptrap)
- [**LLDP**](https://blog.marquis.co/posts/2015-09-07-installing-lldp-on-ubuntu/)