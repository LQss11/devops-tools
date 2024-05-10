#!/bin/sh

while true; do
    echo "Restarting Nginx..."
    nginx -s reload
    sleep 5
done
