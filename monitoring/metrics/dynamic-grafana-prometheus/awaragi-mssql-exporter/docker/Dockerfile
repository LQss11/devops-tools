FROM awaragi/prometheus-mssql-exporter:v1.3.0

WORKDIR /usr/src/app

# Update queries to get an idea of which monitoring tools is running this command
RUN sed -i 's/"SELECT 1"/`SELECT 1`/g' metrics.js
RUN sed -i 's/SELECT/-- MONITORING awaragi-mssql-exporter \nSELECT/g' metrics.js


