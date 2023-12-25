#!/bin/bash
# Get the init process (usually it's /lib/systemd/systemd)
ls -l /sbin/init


## RUNLEVEL COMMANDS (all 3 are the same purpose)
# Get runlevel (e.g 5 is gui 3 is cli only ...)
# Or for file corresponding to the runlevel
runlevel
systemctl get-default
ls -ltr /etc/systemd/system/default.target
# UPDATE runlevel
systemctl set-default multi-user.target
