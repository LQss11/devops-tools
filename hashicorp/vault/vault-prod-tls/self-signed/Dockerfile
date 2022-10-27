FROM vault:latest
USER root
RUN apk --no-cache add jq yq curl
RUN apk add openssl &&\
    mkdir -p /etc/vault/ssl &&\
    openssl req -x509 -days 365 -nodes -newkey rsa:2048 \
    -subj "/CN=localhost" \
    -addext "subjectAltName = IP:127.0.0.1,DNS:localhost" \
    -keyout /etc/vault/ssl/self.key \
    -out /etc/vault/ssl/self.crt
# Manage ssl permissions
RUN addgroup pki &&\
    chgrp -R  pki /etc/vault/ssl/ &&\
    chmod -R g+rx /etc/vault/ssl/ &&\
    addgroup vault pki
##### change /etc/ssl to /vault/ssl
RUN cp /etc/vault/ssl/* /etc/ssl/certs

COPY script /tmp/script
RUN chown vault:vault -R /vault
USER vault
