# Redis commands:
Make sure before running any command to either get in redis cli by running `redis-cli` or simply `redis-cli <REDIS-COMMAND>`
You can run benchmark commands to check the performance of a redis instance:
```sh
redis-benchmark -q -n 1000 -d 10 -t get,set -c 50 -r 1000
```
Here is a set of redis basic commands:
```sh
# Connect to a redis instance
redis-cli <host> -p <port> -a <access-key>
# Get all redis keys
keys *
# Get number of keys in redis instance
dbsize
# Delete all redis keys
flushall
# Set a redis key
set key val
# Get a redis key
get key
# Delete a redis key
del key

# Set and Get multiple keys at the same time
mset key1 val1 key2 val2 key3 val3
mget key1 key2 key3
```
Another example is to create a counter/sequence:
```sh
set seq_id 1
get seq_id
incr seq_id
incr seq_id
get seq_id
```
You can use some additional features in redis cli:
```sh
# Check if key exists in redis
exists key2
# Make a new key expire after 60 seconds
set key val EX 60 
# Make an existing key expire after 60 seconds
expire mykey 60
# To cancel expiration we can run 
persist mykey
```
**We always get the latest set value and the old data is lost**

## Mass insertion

If working with Large CSV files you can convert them to redis like scripts:
```sh
awk -F ',' '{print "SET " $2 " " $1}' countries.csv
wc countries.csv
cat countries.csv | redis-cli --pipe
```
# MISC
Additional commands that could be used:
You can disable or rename commands to prevent other users from running them:
```sh
# rename command
rename-command CONFIG 21384e853ad79f2e70fa8d066acb
# disable command
rename-command CONFIG ""
```

```sh
RENAME mykey newkey
# Rename old key to new key if new key doesn't exist
RENAMEX
PING
MONITOR
ECHO 
# Get time for expiration
TTL KEY
INCRBY
DECR
DECRBY
# LIKE mset but will not perform insertion if key already exist
MSETNX key1 val1 key2 val2
SETNX KEY "val"
# IF key exist value will be appended
APPEND key "stringtoappend"
# prompt old val and set value
GETSET key "newval"
# Set a key that will expire after 10 sec
SETEX mykey 10 "hello"
# Scan commands (rerun the command later with the prompted value to get the rest)
SCAN 0 
SCAN 0 COUNT 2 MATCH key1*
# CONFIG 
CONFIG GET *
INFO all
# Get information about a specific command
COMMAND COUNT
COMMAND INFO GET
# Get info about connected clients/sessions
CLIENT LIST
CLIENT SETNAME clientname
CLIENT GETNAME
CLIENT KILL 127.0.0.1:<port>
CLIENT KILL <id>
``` 