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
# Remove from left side
lpop color
# Remove from right side
rpop color
# Remove all except range of values specified
ltrim color 0 2
```
# Hset key value pair
A set of commands for HashSets data:
```sh
hset product chair 100 table 200 TV 300
hget product chair
hmget product chair table TV
```