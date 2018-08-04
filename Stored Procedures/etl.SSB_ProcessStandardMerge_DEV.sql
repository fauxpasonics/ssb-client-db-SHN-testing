SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[SSB_ProcessStandardMerge_DEV]
(
	@BatchId NVARCHAR(50),
	@Target VARCHAR(256),
	@Source VARCHAR(256),
	@BusinessKey VARCHAR(256),
	@Options NVARCHAR(MAX)
)

AS
BEGIN


/**************************************Comments***************************************
**************************************************************************************
Mod #:		1
Name:		ssbcloud\zfrick
Date:		04/17/2016
Comments:	Dynamically generates and executes standard SSB Merge from source table to destination table.

*************************************************************************************/

DECLARE
     @SQL VARCHAR(MAX),
	 @SQL2 VARCHAR(MAX),
	 @SQL3 VARCHAR(MAX)



SELECT *
INTO #SourceColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = PARSENAME(@Source, 2) AND TABLE_NAME = PARSENAME(@Source, 1)

SELECT *
INTO #TargetColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = PARSENAME(@Target, 2) AND TABLE_NAME = PARSENAME(@Target, 1)


SELECT t.*
INTO #SharedColumns
FROM #SourceColumns s
INNER JOIN #TargetColumns t ON s.COLUMN_NAME = t.COLUMN_NAME
WHERE t.COLUMN_NAME NOT LIKE 'SYNC[_][_]%'



DECLARE @Formula AS VARCHAR(MAX) = ''

SELECT @Formula = @Formula +
' ISNULL(' +
CASE
	WHEN NUMERIC_PRECISION IS NOT NULL THEN 'CONVERT(NVARCHAR(60), [' + COLUMN_NAME + '], 128)'
	WHEN DATA_TYPE LIKE 'datetime%' THEN 'CONVERT(NVARCHAR(30), [' + COLUMN_NAME + '],21)'
	WHEN DATA_TYPE = 'DATE' THEN 'CONVERT(NVARCHAR(8), [' + COLUMN_NAME + '], 112)'
	WHEN DATA_TYPE = 'TIME' THEN 'CONVERT(NVARCHAR(20), [' + COLUMN_NAME + '])'
	WHEN DATA_TYPE = 'bit' THEN 'convert(NVARCHAR(1), [' + COLUMN_NAME + '])'	
	WHEN DATA_TYPE = 'uniqueidentifier' THEN 'convert(NVARCHAR(40), [' + COLUMN_NAME + '])'	
	ELSE '' + COLUMN_NAME + ''
END + ', ''DB_NULL'') COLLATE SQL_Latin1_General_CP1_CS_AS + ' 
FROM #SharedColumns
WHERE ISNULL(CHARACTER_MAXIMUM_LENGTH, 0) >= 0 AND DATA_TYPE NOT LIKE 'BINARY'
AND COLUMN_NAME NOT LIKE 'Sync[_][_]%'
ORDER BY COLUMN_NAME

SET @Formula = 'HASHBYTES(''sha2_256'', ' + LEFT(@Formula, (LEN(@Formula) - 2)) + ')'



DECLARE
	 @ColString VARCHAR(MAX)
SET
	 @ColString = 
	 ( SELECT STUFF ((
                    SELECT ', [' + name + ']'
                    FROM sys.columns
                    WHERE object_id = OBJECT_ID(@Source) 		
					ORDER BY column_id		
                    FOR XML PATH('')), 1, 1, '') 
	 )

DECLARE
	 @HashSyntax VARCHAR(MAX)

DECLARE	 @HashTbl TABLE (HashSyntax VARCHAR(MAX))
INSERT @HashTbl (HashSyntax)
EXEC  etl.SSB_MergeHashFieldSyntax @Source

SET @HashSyntax = (SELECT TOP 1 HashSyntax FROM @HashTbl)

DECLARE
	 @JoinString varchar(MAX)
SET @JoinString = 
	(
		SELECT STUFF ((
        SELECT ' and ' + match  
        FROM
		(
			select 't.' + a.Item + ' = s.' + a.Item as match
			from dbo.Split (@BusinessKey, ',') a 
		)	x	
        FOR XML PATH('')), 1, 5, '')
	)

	DECLARE @SqlStringMax AS VARCHAR(MAX) = ''
	DECLARE @SchemaName  AS VARCHAR(255) = [dbo].[fnGetValueFromDelimitedString](@Source, '.' ,1)
	DECLARE @Table AS VARCHAR(255) = [dbo].[fnGetValueFromDelimitedString](@Source, '.' ,2)

	
	SELECT @SqlStringMax = @sqlStringMax + 'OR ISNULL(s.' + COLUMN_NAME + ','''') <> ' + 'ISNULL(t.' + COLUMN_NAME + ','''') '
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @Table
	AND ISNULL(CHARACTER_MAXIMUM_LENGTH, 0) < 0
--	AND COLUMN_NAME NOT IN ('ETL_ID')	DCH 2016-01-14

	
SELECT @SQL = 
'
BEGIN TRY 


UPDATE ' + @Source + '
SET Sync__DeltaHashKey = ' + @Formula + '


SELECt *
INTO #SrcData
FROM ' + @Source + '

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (' + @BusinessKey + ')
CREATE NONCLUSTERED INDEX IDX_Sync__DeltaHashKey ON #SrcData (Sync__DeltaHashKey)

';

-------------------------------------------------------------------------------------------------

SELECT @SQL2 = 
'
MERGE ' + @Target + ' AS t

USING #SrcData s
    
	ON ' + @JoinString + '

WHEN MATCHED AND (
		
		ISNULL(s.SYNC__DeltaHashKey,-1) <> ISNULL(t.SYNC__DeltaHashKey, -1)		
	 ' + @SqlStringMax + '
)
THEN UPDATE SET
t.SYNC__IsDeleted = 0
, t.SYNC__UpdatedDate = GETDATE()
, t.SYNC__DeltaHashKey = s.SYNC__DeltaHashKey
, ' +
    STUFF ((
            SELECT ',t.[' + COLUMN_NAME + '] = s.[' + COLUMN_NAME + ']' + CHAR(10) + '     '                           
				FROM #SharedColumns
				WHERE COLUMN_NAME NOT LIKE 'SYNC[_][_]%'
				ORDER BY ORDINAL_POSITION
            FOR XML PATH('')), 1, 1, '')  + '

';

-------------------------------------------------------------------------------------------------

SELECT @SQL3 = 
'WHEN NOT MATCHED BY Target
THEN INSERT
     (SYNC__IsDeleted, SYNC__CreatedDate, SYNC__UpdatedDate, SYNC__DeltaHashKey
	 , ' + 
          STUFF ((
                    SELECT ',[' + COLUMN_NAME + ']' + CHAR(10) + '     '
					FROM #SharedColumns				
					WHERE COLUMN_NAME NOT LIKE 'SYNC[_][_]%'
					ORDER BY ORDINAL_POSITION
                    FOR XML PATH('')), 1, 1, '') + ')
VALUES
     (
		0 --SYNC__IsDeleted
		, GETDATE() --SYNC__CreatedDate
		, GETDATE() --SYNC__UpdatedDate
		, s.SYNC__DeltaHashKey
	 , ' + 
          STUFF ((
                    SELECT ',s.[' + COLUMN_NAME + ']' + CHAR(10) + '     '
					FROM #SharedColumns
					WHERE COLUMN_NAME NOT LIKE 'SYNC[_][_]%'				
					ORDER BY ORDINAL_POSITION
                    FOR XML PATH('')), 1, 1, '') + ')
;


END TRY 
BEGIN CATCH 

	DECLARE @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	DECLARE @ErrorState INT = ERROR_STATE();
			
	PRINT @ErrorMessage


	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH

'

PRINT @SQL
PRINT @SQL2 
PRINT @SQL3

DECLARE @Full_SQL NVARCHAR(MAX) = @SQL + @SQL2 + @SQL3;

--print @Full_SQL

EXEC (@Full_SQL)


END








GO
