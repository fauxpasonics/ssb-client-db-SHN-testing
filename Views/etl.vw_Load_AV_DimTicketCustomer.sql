SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_Load_AV_DimTicketCustomer]
AS
(

	SELECT * FROM ods.AV_MV_DimTicketCustomer
)









GO
