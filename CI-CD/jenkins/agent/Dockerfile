# This Dockerfile will:
# Setup and Start (SSH)
# Update root user password to root

# Pull base image.
FROM jenkins/inbound-agent:4.11-1-jdk11

# Avoid on build interaction "noninteractive"
ARG DEBIAN_FRONTEND=noninteractive

# Use User ROOT to get required privileges
USER root

# Create required users
ARG USERNAME=docker
RUN adduser --disabled-password --gecos "Dockerfile defined user" ${USERNAME}

# Update users passwords
RUN echo "${USERNAME}:STRONGPASS" | chpasswd && \
    echo "root:STRONGPASS" | chpasswd && \
    echo "jenkins:STRONGPASS" | chpasswd

# Install initials
RUN \
  apt-get update && \
  apt-get install -y curl wget vim nano net-tools openssh-server inetutils-ping

# install docker-compose
ARG COMPOSE_VERSION=1.23.2
RUN \
  curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Allowing root login with ssh
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Remove Cache
RUN rm -rf /var/cache/apt/*

# Switch to docker user
USER ${USERNAME}