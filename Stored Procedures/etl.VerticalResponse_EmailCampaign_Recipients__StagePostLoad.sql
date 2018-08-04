SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [etl].[VerticalResponse_EmailCampaign_Recipients__StagePostLoad]
(
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)
AS

BEGIN 


	UPDATE stg.VerticalResponse_EmailCampaign_Recipients
	SET Response_Date = CAST(LEFT(Response_Date, LEN(Response_Date) - 4) AS DATETIME)



END
GO
