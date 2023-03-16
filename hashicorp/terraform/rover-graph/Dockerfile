FROM alpine as download
RUN apk add curl jq unzip
RUN LATEST_VERSION=$(curl -s https://api.github.com/repos/im2nguyen/rover/releases/latest | jq -r .tag_name | tr -d 'v') && \
    curl -LO -s https://github.com/im2nguyen/rover/releases/download/v${LATEST_VERSION}/rover_${LATEST_VERSION}_linux_amd64.zip &&\
    unzip rover_${LATEST_VERSION}_linux_amd64.zip &&\
    mv rover_v${LATEST_VERSION} rover &&\
    chmod 777 rover

FROM hashicorp/terraform:latest

COPY --from=download rover /usr/local/bin/rover

EXPOSE 9000
RUN ln -s /bin/terraform /usr/local/bin/terraform
ENTRYPOINT [ "" ]