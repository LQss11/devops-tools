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

# Journalctl
journalctl -b 
journalctl -u docker.service


# Manage Processes
ps auxf
ps -auxf
# Get process id 
pgrep -a sshd

# Prioritize processess with nice value (9 is value of ncie 100 is PID)
sudo nice -n 15 /bin/bash
# Update nice value of sshd process
sudo renice 9 $(ps aux | grep -i sshd | awk '{print $2}' | head -1)
sudo renice 9 $(pgrep sshd)

# get processess nice values
ps lax

# list files that are opened by process
sudo lsof $(ps aux | grep -i sshd | awk '{print $2}' | head -1)

# Get information about process logs
sudo journalctl --unit=sshd.service -n 20 --no-pager

# Send signals (kill -l to list all signals)
sudo systemctl status sshd.service
sudo kill -SIGHUP $(pgrep sshd)
sudo kill -1 $(pgrep sshd)


# Get system errors 
sudo journalctl -p err

# manage background processes
# run in bg
sleep 300 &
# get current jobs in bg
jobs
# bring back something to fg (ctrl + z to put back to background but stopped)
fg 1
fg $(jobs | grep "sleep 300" | grep -o '[0-9]\+' | head -1)
# resume to bg 
bg 1
bg $(jobs | grep "sleep 300" | grep -o '[0-9]\+' | head -1)