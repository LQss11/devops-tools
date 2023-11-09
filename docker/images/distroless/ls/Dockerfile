# Stage 1: Build the C application
FROM gcc:latest as builder
COPY main.c .
RUN gcc -o myapp -static main.c

FROM scratch
WORKDIR /app
COPY --from=builder /myapp /myapp
ENTRYPOINT ["/myapp"]

# docker build -t ls .
# docker run -it --rm -v ${pwd}:/app ls /app