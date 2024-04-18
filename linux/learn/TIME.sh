# NTP: network time protocol
# linux systemd-timesyncd

# Get timezones to determine which tz our servers run at
timedatectl list-timezones
# Set time
timedatectl set-timezone America/New_York
# Get time
timedatectl

# Install utility
apt install systemd-timesyncd
# Set ntp
timedatectl set-ntp true
# Get status
systemctl status systemd-timesync.service

vim /etc/systemd/timesyncd.conf

# example list ntp server
sed -i "s/#NTP/NTP=0.us.pool.ntp.org 1.us.pool.ntp.org/g" /etc/systemd/timesyncd.conf 

# Get timesync status
timedatectl show-timesync
timedatectl timesync-status