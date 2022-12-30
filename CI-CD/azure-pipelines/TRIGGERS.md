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
