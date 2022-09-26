for i in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -i /src/scripts/sql/init.sql
    if [ $? -eq 0 ]
    then
        echo "DBs Initialization Success!"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done



