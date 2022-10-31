# Redis commands:

redis-benchmark -q -n 1000 -d 10 -t get,set -c 50 -r 1000

dbsize

flushall
set key val
get key
keys *

## Mass insertion

If working with csv file
awk -F ',' '{print "SET " $2 " " $1}' countries.csv
wc countries.csv
cat countries.csv | redis-cli --pipe

# Configuration 
any changes need restart
This is the link where you can find the [default redis configuration from multiple versions](https://redis.io/docs/manual/config/)
redis-server /usr/local/etc/redis/redis.conf

To get a specific config value type **CONFIG GET KEY**

save 900 1
save 300 10
save 60 10000