# Gitlab CI
# Gitlab runner
You can install a gitlab runner instance or simply run it using a docker container. Make sure to refer to the [docs](https://docs.gitlab.com/runner/install/)

Make sure **CICD** feature is enabled and create a **.gitlab-ci.yml** file in the root dir.

Go to repo **Settings** -> **CI/CD** -> **Runners**


In case of a docker container simply run:

```sh
# Generate config
docker-compose -f ./generate-config.yaml up -d
docker exec -it gitlab-runner bash -c "rm -rf /etc/gitlab-runner/config.toml && gitlab-runner register"
docker-compose -f ./generate-config.yaml down

# Start runner
docker-compose up
docker-compose down
```