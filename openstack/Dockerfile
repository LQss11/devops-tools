FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y sudo
# Create required users
RUN adduser --disabled-password --gecos "Dockerfile defined user" superuser && \
    echo "superuser:pass123" | chpasswd && \
    echo "superuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


# Run locale to verify
RUN apt-get install -y locales && \
    locale-gen en_US.utf8 && \
    update-locale
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8

# Setup openstack packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y  apache2 apache2-dev bc bsdmainutils curl g++ gawk gcc gettext \
    git graphviz iputils-ping libapache2-mod-proxy-uwsgi libffi-dev libjpeg-dev libpcre3-dev \
    libpq-dev libssl-dev libsystemd-dev libxml2-dev libxslt1-dev libyaml-dev lsof openssh-server \
    openssl pkg-config psmisc python3-dev python3-pip python3-systemd python3-venv tar tcpdump unzip \
    uuid-runtime wget wget zlib1g-dev libkrb5-dev libldap2-dev libsasl2-dev memcached python3-mysqldb \
    sqlite3 conntrack curl ebtables genisoimage iptables iputils-arping kpartx libjs-jquery-tablesorter \
    parted pm-utils python3-mysqldb socat sqlite3 sudo vlan lsscsi open-iscsi cryptsetup dosfstools genisoimage \
    gir1.2-libosinfo-1.0 netcat-openbsd open-iscsi qemu-utils sg3-utils sysfsutils lvm2 qemu-utils thin-provisioning-tools \
    acl dnsmasq-base dnsmasq-utils ebtables haproxy iptables iputils-arping iputils-ping postgresql-server-dev-all \
    python3-mysqldb sqlite3 sudo vlan pcp

RUN apt-get install -y vim git net-tools lsb-release iproute2 python3.10 python3.10-dev iptables \
    rabbitmq-server mysql-server uwsgi uwsgi-plugin-python3 libapache2-mod-proxy-uwsgi


WORKDIR /opt/stack

RUN git clone https://git.openstack.org/openstack-dev/devstack devstack


WORKDIR /opt/stack/devstack
RUN chmod 777 -R /opt/stack && chown superuser:root -R /opt/stack && \
    cp samples/local.conf . && \
    echo "LIBS_FROM_GIT=python-keystoneclient" >>local.conf && \
    echo "HOST_IP=$(hostname -i)" >>local.conf
# docker run -it --rm --user superuser openstack

RUN ln -s /bin/true /sbin/systemctl
RUN systemctl restart my-service # does nothing, successfully
# RUN sudo rabbitmq-server -detached

# docker run -it --rm --user superuser -p 4369 --privileged openstack