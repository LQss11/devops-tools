# Nginx Environment Externalization
Nginx allows you to pass environment variables to its configuration using the built-in entrypoint script called `envsubst`. This script substitutes the environment variables during startup when it finds a file with a `.template` extension under `/etc/nginx/templates`. Once substituted, the generated configuration file is located under `/etc/nginx/conf.d/` and can be referenced in your `nginx.conf` file.

## Example Usage
To demonstrate how to use this feature, you can follow these steps:

1. Create an environment variable file (e.g., `.env`) with the necessary values for your Nginx configuration.

2. Run the following command to build and start your Nginx container using Docker Compose:
```sh
docker-compose up --build
```

1. Once the server is up and running, you can access the Nginx server at [localhost:9999/github](localhost:9999/github), where the **GITHUB_URL** environment variable is referenced from the environment variables provided in your **.env** file.

This setup allows you to easily manage Nginx configuration settings using environment variables, making it more flexible and dynamic.



once server up you can run localhost:9999/github which GITHUB_URL is referenced from the environment variables passed from .env using docker compose