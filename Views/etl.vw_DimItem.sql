SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_DimItem] as 
(
	SELECT * FROM dbo.DimItem_V2
)
GO
