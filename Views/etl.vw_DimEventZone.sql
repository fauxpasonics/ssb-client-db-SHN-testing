SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_DimEventZone] as 
(
	SELECT * FROM dbo.DimEventZone_V2
)
GO
