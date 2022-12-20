# Gitlab CI
# Gitlab runner
You can install a gitlab runner instance or simply run it using a docker container. Make sure to refer to the [docs](https://docs.gitlab.com/runner/install/)

Make sure **CICD** feature is enabled and create a **.gitlab-ci.yml** file in the root dir.

Go to repo **Settings** -> **CI/CD** -> **Runners**


In case of a docker container simply run:
```sh
docker run --rm -it gitlab/gitlab-runner register --non-interactive --url https://gitlab.com/ --registration-token GR1348941U...6K2mrDqh_
```

```sh
docker run -it --rm --name gitlab-runner -v ${pwd}/runner/config.toml:/etc/gitlab-runner/config.toml  -v /usr/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock --entrypoint="" gitlab/gitlab-runner:latest bash
```