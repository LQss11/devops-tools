# Stage 1: Build the C application
FROM gcc:latest as builder
COPY main.c .
RUN gcc -o myapp -static main.c

FROM scratch
WORKDIR /app
COPY --from=builder /myapp /myapp
ENTRYPOINT ["/myapp"]

# docker build -t cat .
# docker run -it --rm -v ${pwd}:/app cat /app/main.c