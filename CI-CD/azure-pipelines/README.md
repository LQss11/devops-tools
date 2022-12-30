# Azure Pipelines
The tasks are available depending on the azure devops version you are using (onprem/cloud) 
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
| ENV_NAME       | Desc                                                   |
| -------------- | ------------------------------------------------------ |
| AZP_URL        | Azure DevOps server instance                           |
| AZP_TOKEN      | PAT (personal access token) with the right permissions |
| AZP_AGENT_NAME | Agent Name                                             |
| AZP_POOL       | Pool name                                              |
| AZP_WORK       | Working directory                                      |


## Build Strategy
Python versions matrix:
```yaml
strrategy:
    matrix: 
        Python27:
            python.version: '2.7'
        Python35:
            python.version: '3.5'            
        Python36:
            python.version: '3.6'
        Python37:
            python.version: '3.7'          
steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '$(python.version)'
      displayName: 'Use Python $(python.version)'
```
VM image name matrix:
```yaml
strrategy:
    matrix: 
        linux:
            imageName: 'ubuntu-16.04'
        mac:
            imageName: 'macos-10.14'            
        windows:
            imageName: 'vs2017-win2016'     
pool:
    vmImage: $(imageName)
```
Multi version on multi vm images:
```yaml
parameters:
- name: imageList
  type: object
  default: ['windows-latest', 'ubuntu-latest']
- name: jdkList
  type: object
  default: ['1.10', '1.11']

jobs:
- ${{ each image in parameters.imageList }}:
  - ${{ each jdk in parameters.jdkList }}:
      - job: ${{ replace(image, '-', '_') }}_${{ replace(jdk, '.', '_') }}
        pool:
          vmImage: ${{ image }}
        steps:
        - script: |
            echo "Image: ${{ image }}, jdk: ${{ jdk }}"
```

