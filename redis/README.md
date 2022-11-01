# Redis
A set of commands, code, configs and more about redis.
# Configuration 
You can usually find redis config in **/usr/local/etc/redis/redis.conf** and after any update you must restart the server with that config to take effect.

* [Example for default redis configuration from multiple versions](https://redis.io/docs/manual/config/)

In order to start a redis server with a specific config you can run:
```sh
redis-server /usr/local/etc/redis/redis.conf
```

To get a specific config value type:
```redis
CONFIG GET KEY
```
# Persistence
Redis stores data in memory (cached) and if we restart or something happen to the server we lose our data so we need to persisted and as examples we can refer to **RDB** or **AOF**

* [https://redis.io/docs/manual/persistence/ ](https://redis.io/docs/manual/persistence/)

RDB persistence
```sh
# Update snapshot every 60 secs if 100 records added
SAVE 60 100
# Save might block client in prod for some time so use this
BGSAVE
```
To Create a backup job on the RDB dump file:
```sh
apt-get install -y rdiff-backup
rdiff-backup --preserve-numerical-ids --no-file-statistics /var/lib/redis /home/redis/backup
# We can also specify it in a cron job
apt-get install cron
crontab -e
# Every midnight
.---------------- minute (0 - 59) 
|  .------------- hour (0 - 23)
|  |  .---------- day of month (1 - 31)
|  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ... 
|  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7)  OR sun,mon,tue,wed,thu,fri,sat 
|  |  |  |  |
0  0  *  *  *  rdiff-backup --preserve-numerical-ids --no-file-statistics /var/lib/redis /home/redis/backup
```
AOF
```sh
# Start writing in aof (aof_rewrites will be =1)
BGREWRITEAOF
INFO Persistence
CONFIG SET appendonly yes
CONFIG SET appendfilename "appendonly.aof"
CONFIG SET appenddirname "appendonlydir"
```
