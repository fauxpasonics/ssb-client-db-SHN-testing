SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[AudienceView_TableSwap] (

	@TableName nvarchar(255)
)

AS
BEGIN


DECLARE @SQL nvarchar(1000);



SET @SQL = CONCAT('EXEC sp_rename ''ods.', @TableName, ''', ''', @TableName, '_old'';');
EXEC sp_executesql @SQL;
--	SELECT @sql; 

SET @SQL = CONCAT('EXEC sp_rename ''ods.', @TableName, '_swap'', ''', @TableName, ''';');
EXEC sp_executesql @SQL;
--	SELECT @sql; 

SET @SQL = CONCAT('EXEC sp_rename ''ods.', @TableName, '_old'', ''', @TableName, '_swap'';');
EXEC sp_executesql @SQL;
--	SELECT @sql; 


END





GO
