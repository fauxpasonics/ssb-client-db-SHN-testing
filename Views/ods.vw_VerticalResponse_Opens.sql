SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ods].[vw_VerticalResponse_Opens]
AS

SELECT ecr.ETL__ID
	, ecr.ETL__CreatedDate
	, ecr.ETL__UpdatedDate
	, crfn.ETL__multi_query_value_for_audit AS CampaignID
	, ecr.List_Name
	, ecr.Response_Type
	, ecr.Response_Date
	, ecr.Email_Address
FROM ods.VerticalResponse_EmailCampaign_Recipients ecr (NOLOCK)
JOIN apietl.VerticalResponse_CampaignRecipients_FileNames crfn (NOLOCK)
	ON ecr.ETL__Source = crfn.ETL__DestinationFileName
WHERE ecr.Response_Type = 'Open'



GO
