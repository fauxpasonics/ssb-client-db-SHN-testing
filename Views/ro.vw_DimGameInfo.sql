SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_DimGameInfo] as 
(
	SELECT * FROM dbo.DimGameInfo_V2 (NOLOCK)
)
GO