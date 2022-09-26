#!/bin/bash
for FILE in /src/scripts/sql/*; do
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -d Test-DB1 -i $FILE
done
