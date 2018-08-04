SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[Load_VerticalResponse_EmailCampaign_Activity]
AS

IF EXISTS (select * from sys.indexes where name = 'IDX_VR_EmailCampaign_Activity')
	DROP INDEX IDX_VR_EmailCampaign_Activity ON etl.VerticalResponse_EmailCampaign_Activity;


SELECT DISTINCT dc.SSB_CRMSYSTEM_CONTACT_ID, ecr.List_Name, ecr.Response_Date UnsubDate
INTO #Unsubscribes
FROM ods.VerticalResponse_EmailCampaign_Recipients ecr (NOLOCK)
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON ecr.Email_Address = dc.EmailPrimary
	AND dc.SourceSystem = 'VerticalResponse'
WHERE ecr.Response_Type = 'Unsubscribe'


SELECT DISTINCT dc.SSB_CRMSYSTEM_CONTACT_ID, ec.CampaignID, ec.[Name] CampaignName, ecl.ListName, ec.MailDate
INTO #Deliveries
FROM ods.VerticalResponse_EmailCampaigns ec (NOLOCK)
JOIN ods.VerticalResponse_EmailCampaigns_Lists ecl (NOLOCK)
	ON ec.CampaignID = ecl.CampaignID
JOIN ods.VerticalResponse_ListMembers lm (NOLOCK)
	ON ecl.ListID = lm.ListID
JOIN ods.VerticalResponse_Subscribers s (NOLOCK)
	ON lm.CID = s.CID
	AND ec.MailDate > s.CreateDate
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON s.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'
LEFT JOIN #Unsubscribes u (NOLOCK)
	ON u.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
	AND u.List_Name = ecl.ListName
WHERE ec.MailDate < ISNULL(u.UnsubDate, GETDATE())

TRUNCATE TABLE etl.VerticalResponse_EmailCampaign_Activity

INSERT INTO etl.VerticalResponse_EmailCampaign_Activity (SSB_CRMSYSTEM_CONTACT_ID, CampaignID
	, CampaignName, ListName, MailDate, DeliveryCount, OpenCount, MinOpenDate, MaxOpenDate, ClickCount
	, MinClickDate, MaxClickDate, BounceCount, MinBounceDate, MaxBounceDate)

SELECT d.SSB_CRMSYSTEM_CONTACT_ID, d.CampaignID, d.CampaignName, d.ListName, CAST(d.MailDate AS DATETIME2)
	, CASE WHEN ISNULL(b.BounceCount, 0) = 0 THEN 1 ELSE 0 END AS DeliveryCount
	, ISNULL(o.OpenCount, 0) AS OpenCount, o.MinOpenDate, o.MaxOpenDate
	, ISNULL(c.ClickCount, 0) AS ClickCount, c.MinClickDate, c.MaxClickDate
	, ISNULL(b.BounceCount, 0) AS BounceCount, b.MinBounceDate, b.MaxBounceDate
FROM #Deliveries d
LEFT JOIN (
		SELECT eca.SSB_CRMSYSTEM_CONTACT_ID, eca.CampaignID
			, COUNT(*) OpenCount, MIN(eca.Response_Date) MinOpenDate, MAX(eca.Response_Date) MaxOpenDate
		FROM etl.vw_VerticalResponse_EmailCampaign_Activities eca (NOLOCK)
		WHERE eca.Response_Type = 'Open'
		GROUP BY eca.SSB_CRMSYSTEM_CONTACT_ID, eca.CampaignID
	) o ON d.SSB_CRMSYSTEM_CONTACT_ID = o.SSB_CRMSYSTEM_CONTACT_ID
		AND d.CampaignID = o.CampaignID
LEFT JOIN (
		SELECT eca.SSB_CRMSYSTEM_CONTACT_ID, eca.CampaignID
			, COUNT(*) ClickCount, MIN(eca.Response_Date) MinClickDate, MAX(eca.Response_Date) MaxClickDate
		FROM etl.vw_VerticalResponse_EmailCampaign_Activities eca (NOLOCK)
		WHERE eca.Response_Type = 'Click'
		GROUP BY eca.SSB_CRMSYSTEM_CONTACT_ID, eca.CampaignID
	) c ON d.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
		AND d.CampaignID = c.CampaignID
LEFT JOIN (
		SELECT eca.SSB_CRMSYSTEM_CONTACT_ID, eca.CampaignID
			, COUNT(*) BounceCount, MIN(eca.Response_Date) MinBounceDate, MAX(eca.Response_Date) MaxBounceDate
		FROM etl.vw_VerticalResponse_EmailCampaign_Activities eca (NOLOCK)
		WHERE eca.Response_Type = 'Bounce'
		GROUP BY eca.SSB_CRMSYSTEM_CONTACT_ID, eca.CampaignID
	) b ON d.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
		AND d.CampaignID = b.CampaignID


IF NOT EXISTS (select * from sys.indexes where name = 'IDX_VR_EmailCampaign_Activity')
	CREATE NONCLUSTERED INDEX IDX_VR_EmailCampaign_Activity on etl.VerticalResponse_EmailCampaign_Activity (SSB_CRMSYSTEM_CONTACT_ID, CampaignID);

GO
