# Redis replication
By adding this parameter you can connect a redis instance to the master instance:

replicaof <masterip> <masterport>

The Master has read write access but workers have only read access so in case the master is down we can use a tool integrated in redis called redis sentinel

For best practice make sure you have 1 master and at least 2 workers

In case a the master in a network and slaves in another network, it's good that we set the following parameters to tell the master that it needs replicas to perform write:
If 1 replica is on master will write if no replicas nothing will be written
```
min-replicas-to-write 1
min-replicas-max-lag 10
```
The redis sentinel is the one responsible for taking actions in case the master die and there is no connection to it so slaves will elect a new master.

Sentinel is usually set in the same node but it can also be set on other nodes and linked to each instance whether master or slave

The quorom in sentinel is the minimum number of sentinels that needs to be available to be able to elect a new master in case of failure
```
sentinel monitor <master-name> <master-ip> <quorom>
```