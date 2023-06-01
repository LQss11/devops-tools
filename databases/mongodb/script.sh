
mongo --host=mongodb
use MAIN
db.createCollection("users")

for (let i = 1; i <= 100; i++) {
  db.users.insert({
    "name": "User " + i,
    "age": Math.floor(Math.random() * 50) + 18,
    "email": "user" + i + "@example.com"
  });
}

db.users.find()
