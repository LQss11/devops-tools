# syntax = docker/dockerfile:experimental
FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json .

COPY app.js .

RUN --mount=type=cache,target=/root/.npm npm i

CMD ["node", "app.js"]

# docker build -t node-agent-test .
# docker run -it --rm -p 3000:3000 node-agent-test