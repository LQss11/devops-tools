#!/bin/sh

# Configuration
VOLUME=myvolume
TARGET_VOLUME=myvolume
USERNAME=root
TARGET=10.10.10.10

# Function to log messages
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting volume transfer script"

# Get the mount point of the Docker volume
log "Inspecting Docker volume ${VOLUME}..."
MOUNTPOINT=$(docker volume inspect ${VOLUME} --format '{{ .Mountpoint }}')
if [ $? -ne 0 ]; then
    log "Error: Failed to inspect Docker volume ${VOLUME}"
    exit 1
fi

log "Volume mount point: ${MOUNTPOINT}"

# Set Docker host environment variable
export DOCKER_HOST="ssh://${USERNAME}@${TARGET}:22"

# Run a temporary Docker container on the remote host
log "Starting temporary Docker container 'mounter' on ${TARGET}..."
docker run -d --rm --name mounter -v ${TARGET_VOLUME}:/volume -w /volume busybox sleep 3600
if [ $? -ne 0 ]; then
    log "Error: Failed to run Docker container 'mounter' on ${TARGET}"
    exit 1
fi

# Copy data from the local Docker volume to the remote container
log "Copying data from ${MOUNTPOINT} to 'mounter:/volume' on ${TARGET}..."
docker cp ${MOUNTPOINT}/. mounter:/volume
if [ $? -ne 0 ]; then
    log "Error: Failed to copy data to 'mounter' container on ${TARGET}"
    exit 1
fi

# Stop the temporary Docker container
log "Stopping 'mounter' container on ${TARGET}..."
docker stop mounter
if [ $? -ne 0 ]; then
    log "Error: Failed to stop 'mounter' container on ${TARGET}"
    exit 1
fi

log "Volume transfer script completed successfully"
