BEGIN TRY
    CREATE DATABASE [TEST];
END TRY
BEGIN CATCH
    -- Do nothing or log the error if needed
END CATCH;