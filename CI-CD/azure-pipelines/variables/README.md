# Variables
```yaml
variables:
    vmImageName:'ubuntu-latest'
pool:
    vmImage: $(vmImageName)
```

Variable groups can be accessed by multiple pipelines you can go to 
1. Pipelines -> Library
2. Create new var group
3. Create variables as plain text or from an Azure Vault
```yaml
variables: 
- group: my-var-group
- name: my-pipeline-var
  value: 'pipeline-var-here'   
```