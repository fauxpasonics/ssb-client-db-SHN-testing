SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [rpt].[vw_DimSeatType]
AS 

SELECT *
FROM dbo.DimSeatType_V2 (NOLOCK)
WHERE ISNULL(ETL__IsDeleted, 0) = 0



GO