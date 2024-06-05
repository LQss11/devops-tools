# Jaeger
# Docker
here is an example on how to setup jaeger for tracing apps:

```sh
docker run --name jaeger -e COLLECTOR_OTLP_ENABLED=true -p 16686:16686 -p 4317:4317 -p 4318:4318 jaegertracing/all-in-one:1.57
```
Once deployed we will need to build and run a python app including otel sdk inside it in this case we are using docker compose

## Docker compose
```sh
# Build the app
docker-compose build python-app
# Run jaeger and the app
docker-compose up -d
```

In this example we can visit jaeger app url ([localhost:16686](http://localhost:16686))to check that the manual instrumentation occured and giving us output.