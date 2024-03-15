#!/bin/bash
# * = match all possible values
# , = match multiple values (i.e., 15,45)
# - = range of values (i.e., 2-4)
# / = specify steps example every 4 hours (i.e., */4)
# default path to cron /etc/crontab
# # Every midnight
# .---------------- minute (0 - 59) 
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ... 
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7)  OR sun,mon,tue,wed,thu,fri,sat 
# |  |  |  |  |
# 0  0  *  *  *  rdiff-backup --preserve-numerical-ids --no-file-statistics /var/lib/redis /home/redis/backup
apt-get install cron
crontab -e

# Get logs of cron
cat /var/log/cron
# See crontab of current user
crontab -l 
# Each user have his own cronta so to edit it either connect as specific user or run this as root
sudo crontab -e -u someuser 

# remove crontab 
crontab -r


# run hourly script (should have no extension)
echo "touch file" >/etc/cron.hourly/shellscript

# anacron schedule jobs even when vm is down job will run the first time it will start 
# every 10 days  5 minutes of delay id log_example
10 5 log_example echo "this is an example log" >>/var/log/example.log
# force anacron to run specfied jobs
anacron -n -f
# at command (specify a date and then you will be asked for commands to be executed) ctrl + d to save
at 15:00
at 'now + 3 hours'
at 'August 20 2025'
at '15:30 August 20 2024'
# get at specified dates of jobs
atq
# get commands to be executed by job number 20
at -c 20
# remove at job
atrm 20