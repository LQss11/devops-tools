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
### uts 
This allow the container to take the same host hostname using (UNIX Time Sharing) option
```yaml
services:
  test:
    image: alpine:latest
    container_name: hostname-tester
    uts: host
    command:
      - hostname
```