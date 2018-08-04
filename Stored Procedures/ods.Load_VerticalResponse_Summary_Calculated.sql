SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [ods].[Load_VerticalResponse_Summary_Calculated]
AS

SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT o.CampaignID) OpenCount
	, MIN(o.Response_Date) MinOpenDate, MAX(o.Response_Date) MaxOpenDate
	, DATEDIFF(dd,MAX(o.Response_Date), GETDATE()) DaysSinceLastOpen
INTO #Opens
FROM ods.VerticalResponse_Opens o
JOIN ods.VerticalResponse_Subscribers s
	ON o.EmailAddress = s.EmailAddress
JOIN dbo.DimCustomer dc
	ON s.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'
JOIN dbo.dimcustomerssbid ssbid
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID


SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT a.CampaignID) DeliveryCount
	, MIN(a.Response_Date) MinDeliveryDate, MAX(a.Response_Date) MaxDeliveryDate
	, DATEDIFF(dd,MAX(a.Response_Date), GETDATE()) DaysSinceLastDelivery
INTO #Deliveries
FROM ods.VerticalResponse_Deliveries a
JOIN ods.VerticalResponse_Subscribers s
	ON a.EmailAddress = s.EmailAddress
JOIN dbo.DimCustomer dc
	ON s.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'
JOIN dbo.dimcustomerssbid ssbid
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID


SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT a.CampaignID) BounceCount
	, MIN(a.Response_Date) MinBounceDate, MAX(a.Response_Date) MaxBounceDate
	, DATEDIFF(dd,MAX(a.Response_Date), GETDATE()) DaysSinceLastBounce
INTO #Bounces
FROM ods.VerticalResponse_Bounces a
JOIN ods.VerticalResponse_Subscribers s
	ON a.EmailAddress = s.EmailAddress
JOIN dbo.DimCustomer dc
	ON s.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'
JOIN dbo.dimcustomerssbid ssbid
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID


SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT a.CampaignID) ClickCount
	, MIN(a.Response_Date) MinClickDate, MAX(a.Response_Date) MaxClickDate
	, DATEDIFF(dd,MAX(a.Response_Date), GETDATE()) DaysSinceLastClick
INTO #Clicks
FROM ods.VerticalResponse_Clicks a
JOIN ods.VerticalResponse_Subscribers s
	ON a.EmailAddress = s.EmailAddress
JOIN dbo.DimCustomer dc
	ON s.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'
JOIN dbo.dimcustomerssbid ssbid
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID


SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT a.CampaignID) UnsubCount
	, MIN(a.Response_Date) MinUnsubDate, MAX(a.Response_Date) MaxUnsubDate
	, DATEDIFF(dd,MAX(a.Response_Date), GETDATE()) DaysSinceLastUnsub
INTO #Unsubscribes
FROM ods.VerticalResponse_Unsubscribes a
JOIN ods.VerticalResponse_Subscribers s
	ON a.EmailAddress = s.EmailAddress
JOIN dbo.DimCustomer dc
	ON s.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'
JOIN dbo.dimcustomerssbid ssbid
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID



SELECT cr.SSB_CRMSYSTEM_CONTACT_ID
	, ISNULL(COALESCE(d.DeliveryCount, o.OpenCount), 0) DeliveryCount, COALESCE(d.MinDeliveryDate, o.MinOpenDate) MinDeliveryDate
	, COALESCE(d.MaxDeliveryDate, o.MaxOpenDate) AS MaxDeliveryDate, COALESCE(d.DaysSinceLastDelivery, o.DaysSinceLastOpen) DaysSinceLastDelivery
	, ISNULL(o.OpenCount, 0) OpenCount, o.MinOpenDate, o.MaxOpenDate, o.DaysSinceLastOpen
	, ISNULL(c.ClickCount, 0) ClickCount, c.MinClickDate, c.MaxClickDate, c.DaysSinceLastClick
	, ISNULL(b.BounceCount, 0) BounceCount, b.MinBounceDate, b.MaxBounceDate, b.DaysSinceLastBounce
	, ISNULL(u.UnsubCount, 0) UnsubCount, u.MinUnsubDate, u.MaxUnsubDate, u.DaysSinceLastUnsub
	, GETDATE() AS ETL__UpdatedDate
INTO ods.VerticalResponse_Summary_Calculated
FROM mdm.compositerecord cr
LEFT JOIN #Bounces b
	ON cr.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN #Clicks c
	ON c.SSB_CRMSYSTEM_CONTACT_ID = cr.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN #Deliveries d
	ON d.SSB_CRMSYSTEM_CONTACT_ID = cr.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN #Opens o
	ON o.SSB_CRMSYSTEM_CONTACT_ID = cr.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN #Unsubscribes u
	ON u.SSB_CRMSYSTEM_CONTACT_ID = cr.SSB_CRMSYSTEM_CONTACT_ID
WHERE d.DeliveryCount IS NOT NULL OR o.OpenCount IS NOT NULL OR c.ClickCount IS NOT NULL OR b.BounceCount IS NOT NULL OR u.UnsubCount IS NOT null
--WHERE ISNULL(COALESCE(d.DeliveryCount, o.OpenCount), 0) <> 0





GO
