FROM openjdk:8

# Install necessary utilities
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6
# Download and install VisualVM
RUN wget -O visualvm_218.zip https://github.com/oracle/visualvm/releases/download/2.1.8/visualvm_218.zip && \
    unzip visualvm_218.zip -d /opt/ && \
    rm visualvm_218.zip && \
    ln -s /opt/visualvm_218/bin/visualvm /usr/local/bin/visualvm

COPY . /usr/src/app
WORKDIR /usr/src/app/src
RUN javac Main.java

ENV DISPLAY=192.168.1.111:0.0

CMD ["visualvm"]