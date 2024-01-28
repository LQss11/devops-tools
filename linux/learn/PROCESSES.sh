# Systemct commands
# Path: /etc/systemd/system/myapp.service
# example file
[Unit]
Description=Some script for my app
Documentation=http://someurl.com
After= postgresql.server
[Service]
ExecStart=/bin/bash /usr/bin/myapp.sh
User=my_service_user
Restart=on-failure
RestartSec=10

[Install]
WantedBy graphical.target

# More sysctl commands
systemctl set-default multi-user.target
systemctl list-units --all

systemctl start myapp.service
systemctl status myapp.service
# To reload changes and update for sysctl steps
systemctl daemon-reload
systemctl start myapp.service

systemctl edit myapp.service --full

systemctl start docker
systemctl stop docker
systemctl restart docker
systemctl reload docker
systemctl status docker
# Enable or disable from the sysctl processess on reboot
systemctl enable docker
systemctl enable --now mercury.service
systemctl disable docker


# Journalctl
journalctl -b 
journalctl -u docker.service