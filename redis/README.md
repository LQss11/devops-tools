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
