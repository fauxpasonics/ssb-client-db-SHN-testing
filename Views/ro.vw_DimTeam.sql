SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_DimTeam] as 
(
	SELECT * FROM dbo.DimTeam_V2 (NOLOCK)
)
GO
