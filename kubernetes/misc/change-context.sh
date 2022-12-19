#!/bin/bash
# You can either control context through kubectl config commands
# Or you can also refer to kubectx
# Get available contexts
kubectl config get-contexts
# Change context
kubectl config use-context docker-desktop