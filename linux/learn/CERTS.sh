#!/bin/bash
# create req (man openssl req)
openssl req -newkey rsa:2048 -keyout kep.pem -out req.pem
# Generate tls cert (equivalent of ssh-keygen)
openssl req -x509 -newkey rsa:4096 -days 365 -keyout myprivate.key -out mycertificate.crt

# Decode cert (man openssl x509)
openssl x509 -in mycertificate.crt -text
