#!/bin/bash
# ./shell/populate-data.sh test Catalog
PATH=$1
DATABASE_NAME=$2
for FILE in /src/scripts/sql/$PATH/*; do
    if [ -f "$FILE" ]; then
        echo "Executing script $FILE..."
        time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -d $DATABASE_NAME -i $FILE
    fi
done
