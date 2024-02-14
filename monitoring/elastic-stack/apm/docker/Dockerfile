ARG VERSION
FROM docker.elastic.co/apm/apm-server:${VERSION}
USER root
COPY ./config/ /usr/share/apm/config/
RUN chmod 755 /usr/share/apm/config/apm-server.yml
