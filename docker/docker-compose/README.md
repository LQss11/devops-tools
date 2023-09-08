# Docker Compose
## Environmens
### Options
you can create a default environment variable value:
```yaml
# ...
    environment:
    - MY_ENV_VAR=${SOME_VARIABLE:-mydefaultvalure}
# ...
```