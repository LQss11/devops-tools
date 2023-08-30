# this is our first build stage, it will not persist in the final image
FROM ubuntu:20.04 as intermediate

# install git
RUN apt-get update
RUN apt-get install -y git

RUN mkdir -p /root/.ssh/
COPY /id_rsa /root/.ssh/id_rsa

# You can enable passing private key through args
# docker build . --force-rm --build-arg SSH_PRIVATE_KEY="-----BEGIN OPENSSH PRIVATE KEY-----c8g6t5...."
# ARG SSH_PRIVATE_KEY
# RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa

# make sure your domain is accepted
RUN chmod 700 /root/.ssh/id_rsa 
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com>> /root/.ssh/known_hosts

RUN git clone git@github.com:username/repo.git

FROM ubuntu:20.04
# copy the repository form the previous image
WORKDIR /app
COPY --from=intermediate /repo /app