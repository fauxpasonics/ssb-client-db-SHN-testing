SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [rpt].[vw_DimSeason]
AS 

SELECT *
FROM dbo.DimSeason_V2 (NOLOCK)
WHERE ISNULL(ETL__IsDeleted, 0) = 0



GO
