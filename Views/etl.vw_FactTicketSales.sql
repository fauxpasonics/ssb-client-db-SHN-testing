SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_FactTicketSales] AS 
(
	SELECT * FROM dbo.FactTicketSales_V2
)
GO
