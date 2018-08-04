SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_Load_AV_DimEventHeader] as 
(
	SELECT *
		, -1 as DimSeasonHeaderId
		, -1 as DimTeamId_Opponent
		, -1 as DimGameInfoId
	FROM ods.AV_MV_DimEventHeader
)

GO
