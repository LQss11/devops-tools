# Redis data types
# List insertion
A set of commands for list insertion
```sh
# Get length of a list (starts from 1 not 0)
llen mylist
# Put data in redis from the begining
lpush color red blue white
#get command wouldn't work here so to do so we need to use lrange instead
# 0 -1 is to get all values in set
# 0 2 will prompt first 3 values 
lrange color 0 -1
lpush color black
# Will Put data by the end of the set
rpush color magenta
lrange color 0 -1
# Get first char
lrange color 0 1
# get last char
lrange mylist -1 -1
lpush color col1 col2 col3
# Remove from left side (first element)
lpop color
# Remove from right side (last element)
rpop color
# Remove a specific key from list
LREM mylist 0 val2
# Remove all except range of values specified
ltrim color 0 2
```
# Set
A set of commands for Sets data:
```sh
SADD myset "val"
SREM myset "val"
# Remove random members (second one remove 3 random members)
SPOP myset
SPOP myset 3
# List all members
SMEMBERS
# Count
SCARD myset
# Check if exists
SMEMBERS myset "val"
# Move members from one set to another
SMOVE people users "John Doe"
# Combine sets
SUNION set1 set2
# Get difference between sets
SDIFF set1 set2

SRANDMEMBER myset
```
# Sorted Sets
A set of commands for Sorted Sets data:
```sh
# 26 is the score and must be specified for each value set
ZADD people 26 "John Doe"
ZREM people "John Doe"
ZSCORE people "John Doe"
# List values sorted lowest to highest
ZRANGE
ZRANGEBYSCORE poeple 0 18
# List values sorted highest to lowest 
ZREVRANGE
# return by rank
ZRANK people "John Doe"
ZREVRANK
# Number of members in sorted set
ZCARD people
ZCOUNT people(0,18) 
# Incr score
ZINCRBY people 5 "John Doe"

```
# Hset key value pair
A set of commands for HashSets data:
```sh
# hset/hmset
hset product chair 100 table 200 TV 300
hget product chair
hmget product chair table TV
hgetall product
hdel product chair
hexists product chair
hincrby product chair
hlen product
hkeys product
hvals product
hstrlen product somestring
```