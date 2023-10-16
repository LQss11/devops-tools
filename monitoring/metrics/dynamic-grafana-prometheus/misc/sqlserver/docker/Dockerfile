# https://dotnetthoughts.net/initialize-mssql-in-docker-container/
FROM mcr.microsoft.com/mssql/server:2019-latest

# Copy all files that will container SQL queries
WORKDIR /src/scripts
COPY config /src/scripts
USER root
RUN chmod -R 777 /src/scripts
USER mssql
# Start the script that will generate initial databases
CMD  /bin/bash /src/scripts/shell/server-init.sh & /opt/mssql/bin/sqlservr

