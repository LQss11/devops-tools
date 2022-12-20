# syntax=docker/dockerfile:1.2

FROM alpine

# shows secret from default secret location:
RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret

# shows secret from custom secret location:
RUN --mount=type=secret,id=mysecret,dst=/foobar cat /foobar

#RUN cat /foobar

RUN  cat /run/secrets/mysecret