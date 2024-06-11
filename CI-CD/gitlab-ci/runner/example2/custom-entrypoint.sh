#!/bin/bash

# Run the gitlab-runner registration command
rm -rf /etc/gitlab-runner/config.toml
gitlab-runner register --non-interactive

# Execute the original entrypoint
exec /usr/bin/dumb-init /entrypoint "$@"
