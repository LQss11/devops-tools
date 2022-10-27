FROM vault:latest
USER root
RUN apk --no-cache add jq yq curl
COPY script /tmp/script
RUN chown vault:vault -R /vault
USER vault
