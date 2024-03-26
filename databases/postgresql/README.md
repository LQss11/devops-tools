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
- **Server:**  postgresql
- **Username:** postgres
- **Password:** root

# Client pgadmin

```sh
docker run -p 5050:80 -e PGADMIN_DEFAULT_EMAIL=youremail@example.com -e PGADMIN_DEFAULT_PASSWORD=yourpassword --name pgadmin -d dpage/pgadmin4
```
# Script

```sh
docker exec -it postgresql bash
PGPASSWORD='root' psql -h postgresql -U root -d initdatabase
```

```sh
PGPASSWORD='root' psql -h localhost -U root -d initdatabase -c "SELECT * FROM \"table\" WHERE date_example_column LIKE '%2024/3/14/10/44%'"
```


```sql
-- Create the schema
"CREATE SCHEMA IF NOT EXISTS app;"
```

```sql
-- Create the table
"CREATE TABLE IF NOT EXISTS app.users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    initials VARCHAR(10),
    location VARCHAR(100),
    pic VARCHAR(100),
    badge VARCHAR(100),
    poste VARCHAR(100),
    bio TEXT
);"
```

```sql
INSERT INTO app.users (name, initials, location, pic, badge, poste, bio)
VALUES
    ('Alice C.', 'AC', 'San Diego, CA', '/demo/avatars/7.jpg', '/images/icons/flags/united-states-of-america.svg', 'Software Engineer', 'This is a nice user description that we can use as demo content'),
    ('Bob D.', 'BD', 'New York, NY', '/demo/avatars/8.jpg', '/images/icons/flags/united-states-of-america.svg', 'Data Analyst', 'Sample bio for Bob'),
    ('Charlie E.', 'CE', 'Los Angeles, CA', '/demo/avatars/9.jpg', '/images/icons/flags/united-states-of-america.svg', 'Product Manager', 'Sample bio for Charlie'),
    ('John S.', 'JS', 'Chicago, IL', '/demo/avatars/10.jpg', '/images/icons/flags/united-states-of-america.svg', 'Software Developer', 'Sample bio for John'),
    ('Emily T.', 'ET', 'San Francisco, CA', '/demo/avatars/11.jpg', '/images/icons/flags/united-states-of-america.svg', 'UI/UX Designer', 'Sample bio for Emily'),
    ('David W.', 'DW', 'Seattle, WA', '/demo/avatars/12.jpg', '/images/icons/flags/united-states-of-america.svg', 'Database Administrator', 'Sample bio for David'),
    ('Emma X.', 'EX', 'Austin, TX', '/demo/avatars/13.jpg', '/images/icons/flags/united-states-of-america.svg', 'Marketing Manager', 'Sample bio for Emma'),
    ('Frank Y.', 'FY', 'Boston, MA', '/demo/avatars/14.jpg', '/images/icons/flags/united-states-of-america.svg', 'Project Coordinator', 'Sample bio for Frank'),
    ('Grace Z.', 'GZ', 'Denver, CO', '/demo/avatars/15.jpg', '/images/icons/flags/united-states-of-america.svg', 'HR Specialist', 'Sample bio for Grace');
```
