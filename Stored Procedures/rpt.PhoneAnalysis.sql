SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [rpt].[PhoneAnalysis]
AS
/*========================================================================================================
		Create master phone list
========================================================================================================*/
CREATE TABLE #MasterPhoneList
(
	Phone				NVARCHAR(255)
	, AudienceView		BIT
	, HelloWorld		BIT
	, VerticalResponse	BIT
	, SurveyMonkey		BIT
	, HamiltonLottery	BIT
	, TodayTix			BIT
	, VividSeats		BIT
	, Bucket			NVARCHAR(255)
	, InPhoneCell		BIT
)


INSERT INTO #MasterPhoneList (Phone)
SELECT DISTINCT PhonePrimary
FROM dbo.DimCustomer
WHERE ISNULL(PhonePrimary, '') <> ''
	UNION
SELECT DISTINCT PhoneCell
FROM dbo.DimCustomer
WHERE ISNULL(PhoneCell, '') <> ''
	UNION
SELECT DISTINCT PhoneHome
FROM dbo.DimCustomer
WHERE ISNULL(PhoneHome, '') <> ''
	UNION
SELECT DISTINCT PhoneBusiness
FROM dbo.DimCustomer
WHERE ISNULL(PhoneBusiness, '') <> ''
	UNION
SELECT DISTINCT PhoneOther
FROM dbo.DimCustomer
WHERE ISNULL(PhoneOther, '') <> ''
	UNION
SELECT DISTINCT PhoneFax
FROM dbo.DimCustomer
WHERE ISNULL(PhoneFax, '') <> ''


-- Update Audience View flags
UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'AudienceView'

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'AudienceView'

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneHome
WHERE dc.SourceSystem = 'AudienceView'

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneBusiness
WHERE dc.SourceSystem = 'AudienceView'

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneFax
WHERE dc.SourceSystem = 'AudienceView'




-- Update Hello World flags
UPDATE m
SET m.HelloWorld = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'HelloWorld'

UPDATE m
SET m.HelloWorld = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'HelloWorld'




-- Update Vertical Response flags
UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'VerticalResponse'

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'VerticalResponse'

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneHome
WHERE dc.SourceSystem = 'VerticalResponse'

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneBusiness
WHERE dc.SourceSystem = 'VerticalResponse'

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneFax
WHERE dc.SourceSystem = 'VerticalResponse'




-- Update Hamilton Lottery flags
UPDATE m
SET m.HamiltonLottery = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'Hamilton Lottery'




-- Update Today Tix flags
UPDATE m
SET m.TodayTix = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'Today Tix'




-- Update Survey Monkey flags
UPDATE m
SET m.SurveyMonkey = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'SurveyMonkey'



-- Update Vivid Seats flags
UPDATE m
SET m.VividSeats = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'Vivid Seats'





/*========================================================================================================
		Create buckets
========================================================================================================*/
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
INTO #Members
FROM dbo.dimcustomerssbid ssbid
JOIN dbo.dimcustomer dc
	ON ssbid.DimCustomerId = dc.DimCustomerId
JOIN ods.AV_ts_contact cont
	ON dc.SSID = CAST(cont.contact_id AS NVARCHAR(255))
JOIN ods.AV_ts_customer_membership cm
	ON cont.contact_parent_id = cm.customermembership_customer_id
JOIN ods.AV_ts_membership m
	ON cm.customermembership_membership_id = m.membership_id
WHERE m.membership_description = 'Season 47'



SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
INTO #Buyers
FROM dbo.dimcustomerssbid ssbid
JOIN dbo.dimcustomer dc
	ON ssbid.DimCustomerId = dc.DimCustomerId
JOIN ods.AV_ts_contact cont
	ON dc.SSID = CAST(cont.contact_id AS NVARCHAR(255))
JOIN ods.AV_ts_order ord
	ON cont.contact_parent_id = ord.order_customer_id
LEFT JOIN #Members m
	ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID
WHERE m.SSB_CRMSYSTEM_CONTACT_ID IS NULL


SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
INTO #NonBuyers
FROM dbo.dimcustomerssbid ssbid
LEFT JOIN #Members m
	ON m.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN #Buyers b
	ON b.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
WHERE m.SSB_CRMSYSTEM_CONTACT_ID IS NULL AND b.SSB_CRMSYSTEM_CONTACT_ID IS NULL
AND ssbid.SourceSystem <> 'HelloWorld'



/*========================================================================================================
		Create phone buckets
========================================================================================================*/
SELECT DISTINCT dc.PhonePrimary Phone
INTO #MemberPhones
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhonePrimary, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneCell Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneCell, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneHome Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneHome, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneBusiness Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneBusiness, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneOther Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneOther, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneFax Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneFax, '') <> ''



SELECT DISTINCT dc.PhonePrimary Phone
INTO #BuyerPhones
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhonePrimary, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneCell Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneCell, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneHome Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneHome, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneBusiness Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneBusiness, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneOther Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneOther, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneFax Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneFax, '') <> ''

DELETE
FROM #BuyerPhones
WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)



SELECT DISTINCT dc.PhonePrimary Phone
INTO #NonBuyerPhones
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhonePrimary, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneCell Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneCell, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneHome Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneHome, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneBusiness Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneBusiness, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneOther Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneOther, '') <> ''
	UNION
SELECT DISTINCT dc.PhoneFax Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneFax, '') <> ''

DELETE
FROM #NonBuyerPhones
WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)

DELETE
FROM #NonBuyerPhones
WHERE Phone IN (SELECT DISTINCT Phone FROM #BuyerPhones)

-- Add Hello World back in
INSERT INTO #NonBuyerPhones (Phone)
SELECT DISTINCT PhoneCell
FROM dbo.DimCustomer dc
LEFT JOIN #MemberPhones m
	ON dc.PhoneCell = m.Phone
LEFT JOIN #BuyerPhones b
	ON dc.PhoneCell = b.Phone
LEFT JOIN #NonBuyerPhones n
	ON dc.PhoneCell =  n.Phone
WHERE SourceSystem = 'HelloWorld'
AND m.Phone IS NULL
AND b.Phone IS NULL
AND n.Phone IS NULL



/*========================================================================================================
		Update master phone list to include buckets
========================================================================================================*/
UPDATE ma
SET ma.Bucket = 'Member'
FROM #MasterPhoneList ma
JOIN #MemberPhones mp
	ON ma.Phone = mp.Phone

UPDATE ma
SET ma.Bucket = 'Buyer'
FROM #MasterPhoneList ma
JOIN #BuyerPhones bp
	ON ma.Phone = bp.Phone
WHERE ma.Bucket IS NULL

UPDATE ma
SET ma.Bucket = 'NonBuyer'
FROM #MasterPhoneList ma
JOIN #NonBuyerPhones nbp
	ON ma.Phone = nbp.Phone
WHERE ma.Bucket IS NULL


/*========================================================================================================
		Set InPhoneCell Flag
========================================================================================================*/
UPDATE m
SET m.InPhoneCell = CASE WHEN dc.DimCustomerId IS NOT NULL THEN 1 ELSE 0 END
FROM #MasterPhoneList m
LEFT JOIN dbo.DimCustomer dc
	ON m.Phone = dc.PhoneCell




/*========================================================================================================
		Load data to materialized table
========================================================================================================*/
TRUNCATE TABLE rpt.MasterPhoneList
INSERT INTO rpt.MasterPhoneList (Phone, AudienceView, HelloWorld, VerticalResponse, SurveyMonkey, HamiltonLottery, TodayTix, VividSeats, Bucket, InPhoneCell, UpdateDate)
SELECT Phone, AudienceView, HelloWorld, VerticalResponse, SurveyMonkey, HamiltonLottery, TodayTix, VividSeats, Bucket, InPhoneCell, GETDATE()
FROM #MasterPhoneList

GO
