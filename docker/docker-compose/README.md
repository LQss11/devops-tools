# Docker Compose
## Environmens
### Options
#### Default Value
you can create a default environment variable value:
```yaml
# ...
    environment:
    - MY_ENV_VAR=${SOME_VARIABLE:-mydefaultvalure}
# ...
```
#### Mandatory KEY
```yaml
# ...
    environment:
    - MY_ENV_VAR=${SOME_VARIABLE?Variable SOME_VARIABLE not set}
# ...
```