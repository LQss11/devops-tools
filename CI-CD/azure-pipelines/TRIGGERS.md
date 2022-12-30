# Triggers
## CI trigger (Branch)
```yaml
trigger:
    branches:
        include:
        - master
        - releases/*
        - /refs/tags/{tagname}
        exclude:
        - releases/old*
    paths:
        include:
            - terraform/staging/*        
```
## Scheduled Triggers:
```yaml
schedules:
  - cron: '*/10 * * * *'
    displayName: my-scheduled-build
    branches: 
        include:
        - new-feature
    always: true
```
