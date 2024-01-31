# atmoz/sftp
```sh
docker-compose up -d --build 
# Accept host and pass password through arguments (test only)
docker exec -it openssh sh -c "sshpass -p 'pass' sftp -o StrictHostKeyChecking=no -P 22 foo@sftp"
```