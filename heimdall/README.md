# Heimdall
Heimdall is a tool to manage applications urls through a user friendly interface.
you can run this command to start it:
```sh
docker compose up -d
```
# Forgot Password
In case you forgot your password you can run the following commands:
```sh
docker exec -it heimdall bash
apk add sqlite && sqlite3 /config/www/app.sqlite
SELECT * FROM USERS;
# $2a$10$koJCrZOfyrktBMO9bGJzm.Sw8IRzLNcBgMO5xDmzwmEut5kDC0fIy = mypassword (converted using bcrypt)
UPDATE users SET password="$2a$10$koJCrZOfyrktBMO9bGJzm.Sw8IRzLNcBgMO5xDmzwmEut5kDC0fIy" WHERE username='admin';
```