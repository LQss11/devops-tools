#!/bin/bash
# Install jdk if not already installed
apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/*
# Install necessary utilities
apt-get update && apt-get install -y \
    wget \
    unzip \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6

# Download and install VisualVM
wget -O visualvm_218.zip https://github.com/oracle/visualvm/releases/download/2.1.8/visualvm_218.zip && \
    unzip visualvm_218.zip -d /opt/ && \
    rm visualvm_218.zip && \
    ln -s /opt/visualvm_218/bin/visualvm /usr/local/bin/visualvm

export DISPLAY=192.168.1.111:0.0