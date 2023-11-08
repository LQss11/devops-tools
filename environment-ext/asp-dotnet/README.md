# Appsettings environment externalization
There are several third-party tools that allow you to convert .NET appsettings variables into environment variables. These environment variables can then be used as container or virtual machine environment variables and interpreted accordingly by the runtime application.

# Example
To create a new environment variable file, you can run the following commands:
```sh
docker build -t dotnet-appsettings-env .
docker run -it -v ${pwd}:/app -w /app --rm dotnet-appsettings-env -type='docker' -separator='__' -file='./env.json' >> .env
```