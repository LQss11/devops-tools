FROM ubuntu:20.04
WORKDIR /usr/src/certs

RUN apt-get update && apt-get install -y openssl wget curl

# Install kubectl
ARG KUBERNETES_RELEASE=v1.27.3
ARG ARCH=amd64
RUN wget https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_RELEASE}/bin/linux/${ARCH}/kubectl -O /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Install kubectx
RUN echo "deb [trusted=yes] http://ftp.de.debian.org/debian buster main" >>/etc/apt/sources.list && \
    apt-get update && \
    apt-get install kubectx -y
    
COPY . .
