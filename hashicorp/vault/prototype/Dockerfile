FROM vault:latest
RUN apk --no-cache add jq yq curl libcap && \
    setcap cap_ipc_lock= /usr/sbin/vault

ENV VAULT_ADDR='http://127.0.0.1:8200'


