SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [ro].[vw_DimActivity] as 
(
	SELECT * FROM dbo.DimActivity_V2 (NOLOCK)
)
GO
