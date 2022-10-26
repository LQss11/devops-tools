FROM vault:latest
RUN apk --no-cache add jq yq curl libcap && \
    setcap cap_ipc_lock= /usr/sbin/vault

ENV VAULT_ADDR='http://127.0.0.1:8200'

RUN apk add openssl &&\
mkdir /etc/vault/ssl &&\
openssl req -x509 -days 365 -nodes -newkey rsa:2048 \
-subj "/CN=vault-CA" \
-keyout /etc/vault/ssl/self.key \
-out /etc/vault/ssl/self.crt

# Vault config https://www.vaultproject.io/docs/config/index.html
COPY config/hcl/config /vault/config/