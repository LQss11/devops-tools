FROM docker:dind
WORKDIR /usr/src/app
EXPOSE 22
RUN apk add curl wget bash net-tools openssh openrc arp-scan nmap

# Setup SSH Service
RUN rc-update add sshd &&  \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A

VOLUME [ "/var/lib/docker" ]
COPY . . 
# COPY entrypoint.sh entrypoint.sh
RUN chmod 777 *.sh

ENTRYPOINT ["./entrypoint.sh"]