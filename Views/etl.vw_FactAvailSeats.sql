SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_FactAvailSeats] AS 
(
	SELECT * FROM dbo.FactAvailSeats_V2
)
GO
