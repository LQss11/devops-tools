# Azure Pipelines
The tasks are available depending on the azure devops version you are using (onprem/cloud) 
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

