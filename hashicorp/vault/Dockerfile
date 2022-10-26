FROM vault:latest
RUN apk --no-cache add jq yq curl

RUN apk add openssl &&\
    mkdir -p /etc/vault/ssl &&\
    openssl req -x509 -days 365 -nodes -newkey rsa:2048 \
    -subj "/CN=vault-CA" \
    -keyout /etc/vault/ssl/self.key \
    -out /etc/vault/ssl/self.crt
# Manage permissions
RUN addgroup pki &&\
    chgrp -R  pki /etc/vault/ssl/ &&\
    chmod -R g+rx /etc/vault/ssl/ &&\
    addgroup vault pki

# Vault config https://www.vaultproject.io/docs/config/index.html
#COPY config/hcl/config.hcl /vault/config/
#COPY config/json/config.json /vault/config/