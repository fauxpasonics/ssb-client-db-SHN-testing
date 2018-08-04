SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_FactInventory] as 
(
	SELECT * FROM dbo.FactInventory_V2
)
GO
