FROM hashicorp/vault:1.15
USER root
RUN apk --no-cache add jq yq curl
RUN mkdir -p /opt/vault/ && mkdir -p /opt/vault/data/ && chown vault:vault -R /opt/vault/data
USER vault
