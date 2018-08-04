SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_DimTicketCustomer] as 
(
	SELECT * FROM dbo.DimTicketCustomer_V2 (NOLOCK)
)
GO
