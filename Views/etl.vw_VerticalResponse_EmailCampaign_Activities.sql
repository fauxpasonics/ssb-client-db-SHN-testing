SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_VerticalResponse_EmailCampaign_Activities]
AS

SELECT dc.SSB_CRMSYSTEM_CONTACT_ID, ecr.Email_Address
	, fn.ETL__multi_query_value_for_audit CampaignID, ec.[Name] CampaignName
	, ecr.List_Name, ecr.Response_Type, ecr.Response_Date
	, ecr.Click_Text, ecr.Click_URL
FROM ods.VerticalResponse_EmailCampaign_Recipients ecr (NOLOCK)
JOIN apietl.VerticalResponse_CampaignRecipients_FileNames fn (NOLOCK)
	ON ecr.ETL__Source = fn.ETL__DestinationFileName
JOIN ods.VerticalResponse_EmailCampaigns ec (NOLOCK)
	ON fn.ETL__multi_query_value_for_audit = ec.CampaignID
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON ecr.Email_Address = dc.EmailPrimary
	AND dc.SourceSystem = 'VerticalResponse'




GO
