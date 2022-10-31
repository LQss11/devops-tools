# Redis commands:

redis-benchmark -q -n 1000 -d 10 -t get,set -c 50 -r 1000

keys *
dbsize

flushall
set key val
get key
del key


set seq_id 1
get seq_id
incr seq_id
incr seq_id
get seq_id

mset key1 val1 key2 val2 key3 val3
mget key1 key2 key3

exists key2

Make a new key expire after 60 seconds
set key val EX 60 
Make an existing key expire after 60 seconds
expire mykey 60
To cancel expiration we can run 
persist mykey

We always get the latest set value and the old data is lost
# List insertion
lpush color red blue white
get command wouldn't work here so to do so we need to use 
lrange color 0 -1
lpush color black
rpush color magenta
lrange color 0 -1
lpush color col1 col2 col3

Remove from left side
lpop color
Remove from right side
rpop color

Remove all except range of values specified
ltrim color 0 2

# Hset key value pair
hset product chair 100 table 200 TV 300
hget product chair
hmget product chair table TV
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

# Persistence
[https://redis.io/docs/manual/persistence/ ](https://redis.io/docs/manual/persistence/)