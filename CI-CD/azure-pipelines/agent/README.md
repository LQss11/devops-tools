# Azure Agents
# Quick start
Make sure to update .env file containing the azure devops pipeline access using the persoanl access token (pat)
```sh
# Build docker image 
docker compose up --build -d
``` 
# Setup self hosted agent
In order to setup a self hosted agentdo the following:
## Create PAT
* Go to your profile's user settings -> Security
* Create PAT (Personal access token) and make sure it has the right permissions (Bare min is **read and manage pools**)
* Make sure to save the token once created
## Create a Pool
* Go to Azure devops organization settings
* Go to Pipelines -> agent pools
* Select Default and click on create new agent on top right
* Download binaries
* Run ./config.cmd (use the right config and PAT)
* Run ./run.cmd
## Agents pools
```sh
# Microsoft Hosterd
pool:
    vmImage: ubuntu-20.04
# Self Hosted
pool:
    name: 'mypool'
# Docker
# Docker in self hosted
pool:
    name: 'mypool'
container: ubuntu:20.04
steps:
- script: echo "Hello World!"
``` 
## Setup containerized agents
We need to setup the following environment variables and follow this [link](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#linux):
| ENV_NAME               | Desc                                                   |
| ---------------------- | ------------------------------------------------------ |
| VSTS_AGENT_INPUT_URL   | Azure DevOps server instance                           |
| VSTS_AGENT_INPUT_AUTH  | Authentication method for the agent e.g. pat           |
| VSTS_AGENT_INPUT_TOKEN | PAT (personal access token) with the right permissions |
| VSTS_AGENT_INPUT_AGENT | Agent Name                                             |
| VSTS_AGENT_INPUT_POOL  | Pool name                                              |
| VSTS_AGENT_INPUT_WORK  | Working directory                                      |

