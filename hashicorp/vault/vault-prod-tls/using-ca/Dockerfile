FROM vault:latest
USER root

RUN apk --no-cache add jq yq curl

RUN mkdir -p /etc/vault/ssl/
COPY certs /etc/vault/ssl/
RUN cp /etc/vault/ssl/* /etc/ssl/certs

COPY script /tmp/script

RUN chown vault:vault -R /vault

USER vault
