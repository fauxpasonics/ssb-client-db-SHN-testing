SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_FactTicketActivity] as 
(
	SELECT * FROM dbo.FactTicketActivity_V2
)
GO
