SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [rpt].[vw_DimTicketCustomer]
AS 

SELECT *
FROM dbo.DimTicketCustomer_V2 (NOLOCK)
WHERE ISNULL(ETL__IsDeleted, 0) = 0



GO