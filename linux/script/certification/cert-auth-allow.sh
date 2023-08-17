#!/bin/sh
apk update
apk add ca-certificates
cp /example/path/mywebsite.crt /usr/local/share/ca-certificates/mywebsite.crt
update-ca-certificates 