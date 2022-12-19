#!/bin/bash
# Get available contexts
kubectl config get-contexts
# Change context
kubectl config use-context docker-desktop