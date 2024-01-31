# Quick start
```sh
docker-compose up --build
```
```sh
docker-compose down -v 
```
# Credentials
visit adminer url at **localhost:8888**
- **System:** MYSQL
- **Server:**  mysql
- **Username:** root
- **Password:** root

visit mongoclient url at **localhost:3300**
Create a new connection by clicking on top right corner connection button and add the following connection string: **mongodb://root:root@mongodb:27017**

# CLI
```sh

# Show databases
mongo --quiet -u admin --host localhost --eval "printjson(db.adminCommand('listDatabases'))"
# Or login
mongo --quiet -u admin --host localhost
# Create database and collection inside it
use Example_Database
# Create collection
db.createCollection("my_new_database_collection")
# Then list dbs with native commands
show dbs
# Show current db
db
# Show collections in db
show collections
```

# Notice
When using latest docker image You will get this 
```sh
WARNING: MongoDB 5.0+ requires a CPU with AVX support, and your current system does not appear to have that!
  see https://jira.mongodb.org/browse/SERVER-54407
  see also https://www.mongodb.com/community/forums/t/mongodb-5-0-cpu-intel-g4650-compatibility/116610/2
  see also https://github.com/docker-library/mongo/issues/485#issuecomment-891991814
/usr/local/bin/docker-entrypoint.sh: line 416:    26 Illegal instruction     (core dumped) "${mongodHackedArgs[@]}" --fork
```
you can check this issue on gh **Mongo 5.0.0 crashes but 4.4.6 works** [#485](https://github.com/docker-library/mongo/issues/485)