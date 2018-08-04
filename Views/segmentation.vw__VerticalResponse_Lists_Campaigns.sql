SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [segmentation].[vw__VerticalResponse_Lists_Campaigns]
AS

SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, lm.ListID, el.ListName, ec.CampaignID
	, ec.[Name] CampaignName
	, ec.[Type] CampaignType
	, ec.[Status] CampaignStatus
	, ec.FromLabel
	, ec.SupportEmail
	, ec.CreationDate CampaignCreationDate
	, ec.LastUpdated CampaignLastUpdated
	, ec.MailDate CampaignMailDate
--SELECT *
FROM ods.VerticalResponse_EmailCampaigns ec
JOIN ods.VerticalResponse_EmailCampaigns_Lists el
	ON el.CampaignID = ec.CampaignID
JOIN ods.VerticalResponse_ListMembers lm
	ON lm.ListID = el.ListID
JOIN dbo.DimCustomer dc
	ON dc.SSID = lm.CID
	AND dc.SourceSystem = 'VerticalResponse'
JOIN dbo.dimcustomerssbid ssbid
	ON ssbid.DimCustomerID = dc.DimCustomerId







GO
