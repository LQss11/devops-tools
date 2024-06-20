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
MOUNTPOINT=$(docker volume inspect ${VOLUME} --format '{{ .Mountpoint }}')
if [ $? -ne 0 ]; then
    log "Error: Failed to inspect Docker volume ${VOLUME}"
    exit 1
fi

log "Volume mount point: ${MOUNTPOINT}"

# Copy the volume data to the target
log "Copying data from ${MOUNTPOINT} to ${TARGET}:/tmp/${TARGET_VOLUME}"
scp -r ${MOUNTPOINT} ${USERNAME}@${TARGET}:/tmp/${TARGET_VOLUME}
if [ $? -ne 0 ]; then
    log "Error: Failed to copy data to target"
    exit 1
fi

# Run a temporary Docker container on the target
log "Running temporary Docker container on target"
ssh ${USERNAME}@${TARGET} -T "docker run -d --rm --name mounter -v ${TARGET_VOLUME}:/volume -w /volume busybox sleep 3600"
if [ $? -ne 0 ]; then
    log "Error: Failed to run Docker container on target"
    exit 1
fi

# Copy data from the temporary location to the Docker volume
log "Copying data from /tmp/${TARGET_VOLUME}/. to Docker volume in container"
ssh ${USERNAME}@${TARGET} -T "docker cp /tmp/${TARGET_VOLUME}/. mounter:/volume"
if [ $? -ne 0 ]; then
    log "Error: Failed to copy data into Docker volume in container"
    exit 1
fi

# Stop the temporary Docker container
log "Stopping temporary Docker container"
ssh ${USERNAME}@${TARGET} -T "docker stop mounter"
if [ $? -ne 0 ]; then
    log "Error: Failed to stop Docker container on target"
    exit 1
fi

log "Volume transfer script completed successfully"
