SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ods].[vw_VerticalResponse_Deliveries]
AS

SELECT ec.CampaignID
	, ecl.ListID
	, ecl.ListName
	, 'Delivery' AS ResponseType
	, ec.MailDate AS Response_Date
	, s.EmailAddress
	, ec.ETL_CreatedOn AS ETL__CreatedDate
	, ec.ETL_UpdatedOn AS ETL__UpdatedDate
FROM ods.VerticalResponse_EmailCampaigns ec (NOLOCK)
JOIN ods.VerticalResponse_EmailCampaigns_Lists ecl (NOLOCK)
	ON ec.CampaignID = ecl.CampaignID
JOIN ods.VerticalResponse_ListMembers lm (NOLOCK)
	ON ecl.ListID = lm.ListID
	AND ec.MailDate >= lm.CreateDate
	AND ec.MailDate < (CASE WHEN lm.OptInStatus = 'Unsubscribed' THEN lm.OptInStatusLastUpdated
							ELSE GETDATE() END)
JOIN ods.VerticalResponse_Subscribers s (NOLOCK)
	ON lm.CID = s.CID
LEFT JOIN ods.VerticalResponse_Bounces b (NOLOCK)
	ON ec.CampaignID = b.CampaignID
	AND ecl.ListName = b.List_Name
	AND s.EmailAddress = b.EmailAddress
WHERE b.ID IS NULL

GO
