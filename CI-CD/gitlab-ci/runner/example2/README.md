# Gitlab Agent
This documentation illustrates how to create a global gitlab agent using simple commands.
# Setup
First you will need to go to the [admin runners url](https://my-gitlab.dev/admin/runners) in order to be able to get the agent token.

## Quick start
```sh
# gitlab-runner register --non-interactive
# Run agent (make sure to update .env if needed)
docker-compose up --build --force-recreate -d
```


# Addition docs references
- [Docker agent installation](https://docs.gitlab.com/runner/install/docker.html)
- [Linux agent installation](https://docs.gitlab.com/runner/install/linux-repository.html)
- [Agent config environment variables](https://gist.github.com/Mearman/318b96efb31ed33d9c2efa959784d6d8)