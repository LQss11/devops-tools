FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html

RUN \
apk add openssl &&\
mkdir /etc/nginx/ssl &&\
openssl req -x509 -days 365 -nodes -newkey rsa:2048 \
-subj "/CN=NGINX-CA" \
-keyout /etc/nginx/ssl/self.key \
-out /etc/nginx/ssl/self.crt &&\
# Generate Diffie hellman pem key
openssl dhparam 2048 -out /etc/nginx/ssl/dhparam.pem

COPY /config/default.conf /etc/nginx/templates/default.conf.template