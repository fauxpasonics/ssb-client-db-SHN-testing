SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_DimPriceChart] as 
(
	SELECT * FROM dbo.DimPriceChart_V2
)

GO
