SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [segmentation].[vw__HelloWorld_TextCampaigns]
AS

WITH Phones
AS (
	SELECT dc.DimCustomerId, SourceSystem, SSID
		, REPLACE(REPLACE(REPLACE(REPLACE(dc.PhonePrimary, ')', ''), '(', ''), '-', ''), ' ', '') PhonePrimary
		, REPLACE(REPLACE(REPLACE(REPLACE(dc.PhoneHome, ')', ''), '(', ''), '-', ''), ' ', '') PhoneHome
		, REPLACE(REPLACE(REPLACE(REPLACE(dc.PhoneCell, ')', ''), '(', ''), '-', ''), ' ', '') PhoneCell
		, REPLACE(REPLACE(REPLACE(REPLACE(dc.PhoneBusiness, ')', ''), '(', ''), '-', ''), ' ', '') PhoneBusiness
		, REPLACE(REPLACE(REPLACE(REPLACE(dc.PhoneOther, ')', ''), '(', ''), '-', ''), ' ', '') PhoneOther
		, REPLACE(REPLACE(REPLACE(REPLACE(dc.PhoneFax, ')', ''), '(', ''), '-', ''), ' ', '') PhoneFax
	FROM dbo.DimCustomer dc
	WHERE SourceSystem <> 'HelloWorld'
	AND (ISNULL(dc.PhonePrimary, '') <> ''
		OR ISNULL(dc.PhoneHome, '') <> ''
		OR ISNULL(dc.PhoneCell, '') <> ''
		OR ISNULL(dc.PhoneBusiness, '') <> ''
		OR ISNULL(dc.PhoneOther, '') <> ''
		OR ISNULL(dc.PhoneFax, '') <> '')
)

SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID
	, dv.subscriberid HelloWorld_SubscriberID
	, d.datafieldid HelloWorld_DataFieldID
	, d.[name] HelloWorld_DataFieldName
	, dv.[value] HelloWorld_Response_Value
	, dv.stamp HelloWorld_Response_Timestamp
FROM ods.HelloWorld_Datafields d
JOIN ods.HelloWorld_DatafieldValues dv
	ON d.datafieldid = dv.datafieldid
JOIN ods.HelloWorld_Subscribers sub
	ON dv.subscriberid = sub.subscriberid
JOIN Phones dc
	ON sub.phone = dc.PhonePrimary
		OR sub.phone = dc.PhoneHome
		OR sub.phone = dc.PhoneCell
		OR sub.phone = dc.PhoneBusiness
		OR sub.phone = dc.PhoneOther
		OR sub.phone = dc.PhoneFax
JOIN dbo.dimcustomerssbid ssbid
	ON dc.DimCustomerId = ssbid.DimCustomerId

GO
