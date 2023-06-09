# INSTALL AZURE CLI
to use it [inside container](https://docs.microsoft.com/en-us/cli/azure/run-azure-cli-docker?view=azure-cli-latest):
```sh
docker pull mcr.microsoft.com/azure-cli
docker tag mcr.microsoft.com/azure-cli:latest az
docker run -it az
```
You can also install it on your host machine, follow this [link](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).