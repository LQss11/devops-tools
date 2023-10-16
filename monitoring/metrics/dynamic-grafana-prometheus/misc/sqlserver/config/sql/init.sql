BEGIN TRY
    /* Use [BRACKETS] to avoid syntax error on creating dbs with '-' sign*/
    CREATE DATABASE Catalog;
    CREATE DATABASE [Catalog-Master];

END TRY
BEGIN CATCH
    -- Do nothing or log the error if needed
END CATCH;
