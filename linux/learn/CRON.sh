#!/bin/bash
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