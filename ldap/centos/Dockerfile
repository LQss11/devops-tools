FROM centos:7

RUN yum install -y sssd && yum clean all

COPY sssd.conf /etc/sssd/sssd.conf
RUN chmod 600 /etc/sssd/sssd.conf

COPY startup.sh /startup.sh
RUN chmod 744 /startup.sh

CMD ["/startup.sh"]