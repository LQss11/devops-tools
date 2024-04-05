# Systemct commands
# example file Path: /etc/systemd/system/myapp.service

# More sysctl commands
systemctl set-default multi-user.target
systemctl list-units --type service --all

systemctl start myapp.service
systemctl status myapp.service
# To reload changes and update for sysctl steps
systemctl daemon-reload
systemctl start myapp.service

systemctl edit myapp.service --full
# before accepting changes if we want to revert we can run
systemctl revert myapp.service 

systemctl start docker
systemctl stop docker
systemctl restart docker
systemctl reload docker
systemctl status docker
# Enable or disable from the sysctl processess on reboot
systemctl enable docker
systemctl enable --now mercury.service
systemctl disable docker

# Mask service to track issues sometimes a service starts another service even when it's stopped
systemctl mask atd.server
systemctl unmask atd.server

# get all dependeincies
systemctl list-dependencies