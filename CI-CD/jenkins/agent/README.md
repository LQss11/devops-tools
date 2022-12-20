# Jenkins
Initialize a new jenkins agent config go to [http://localhost:8090/manage/computer/new](http://localhost:8090/manage/computer/new), pick a name and check **Permanent Agent**.

After clicking next put the right desc, tags, workdir (**default:/home/jenkins/agent/**), and launch method to (**Launch agent by connecting it to the controller**) + pick Use WebSocket then save.

Once you have created a new agent click on it and copy paste the secret and url to the .env file then run:
```sh
docker-compose -p jenkins -f docker-compose-agent.yaml up -d
```

To run docker container make sure to give access to use the docker socket:
```sh
docker exec -it --user root jenkins-container-slave sh -c "chmod 777 /var/run/docker.sock"
```