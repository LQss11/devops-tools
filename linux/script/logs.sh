#!/bin/bash
# Log messages
log() {
    current_time=$(date +"%Y-%m-%d %H:%M:%S")
    script_name=$(basename "$0")
    echo "[$current_time] [$script_name] [INFO] $1"
}
log "Hello this is my script execution."
