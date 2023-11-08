# https://github.com/dassump/dotnet-appsettings-env
FROM alpine
ADD https://github.com/dassump/dotnet-appsettings-env/releases/download/v1.2.1/dotnet-appsettings-env-linux-amd64 /bin/dotnet-appsettings-env
RUN chmod +x /bin/dotnet-appsettings-env
ENTRYPOINT [ "dotnet-appsettings-env" ]
CMD [ "--help" ]
# docker build -t dotnet-appsettings-env .
# docker run -it -v ${pwd}:/app --rm dotnet-appsettings-env -type='docker' -separator='__' -file='/app/env.json'
