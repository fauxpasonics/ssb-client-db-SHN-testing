SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_DimSeasonHeader] as 
(
	SELECT * FROM dbo.DimSeasonHeader_V2
)
GO
