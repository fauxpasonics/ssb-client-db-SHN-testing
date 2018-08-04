SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [rpt].[Get_PhoneNumbersNotInHW] (@UpdatedDate DATE)
AS

--DECLARE @UpdatedDate DATE = ''

SET @UpdatedDate = CASE WHEN ISNULL(@UpdatedDate, '') = '' THEN CAST((GETDATE() - 7) AS DATE) ELSE @UpdatedDate END

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
FROM dbo.DimCustomer (NOLOCK)
WHERE ISNULL(PhonePrimary, '') <> ''
AND PhonePrimaryIsCleanStatus = 'Valid'
AND SSCreatedDate >= @UpdatedDate
	UNION
SELECT DISTINCT PhoneCell
FROM dbo.DimCustomer (NOLOCK)
WHERE ISNULL(PhoneCell, '') <> ''
AND PhoneCellIsCleanStatus = 'Valid'
AND SSCreatedDate >= @UpdatedDate
	UNION
SELECT DISTINCT PhoneHome
FROM dbo.DimCustomer (NOLOCK)
WHERE ISNULL(PhoneHome, '') <> ''
AND PhoneHomeIsCleanStatus = 'Valid'
AND SSCreatedDate >= @UpdatedDate
	UNION
SELECT DISTINCT PhoneBusiness
FROM dbo.DimCustomer (NOLOCK)
WHERE ISNULL(PhoneBusiness, '') <> ''
AND PhoneBusinessIsCleanStatus = 'Valid'
AND SSCreatedDate >= @UpdatedDate
	UNION
SELECT DISTINCT PhoneOther
FROM dbo.DimCustomer (NOLOCK)
WHERE ISNULL(PhoneOther, '') <> ''
AND PhoneOtherIsCleanStatus = 'Valid'
AND SSCreatedDate >= @UpdatedDate
	UNION
SELECT DISTINCT PhoneFax
FROM dbo.DimCustomer (NOLOCK)
WHERE ISNULL(PhoneFax, '') <> ''
AND PhoneFaxIsCleanStatus = 'Valid'
AND SSCreatedDate >= @UpdatedDate


-- Update Audience View flags
UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'AudienceView'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'AudienceView'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneHome
WHERE dc.SourceSystem = 'AudienceView'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneBusiness
WHERE dc.SourceSystem = 'AudienceView'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.AudienceView = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneFax
WHERE dc.SourceSystem = 'AudienceView'
AND dc.SSCreatedDate >= @UpdatedDate




-- Update Hello World flags
UPDATE m
SET m.HelloWorld = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'HelloWorld'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.HelloWorld = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'HelloWorld'
AND dc.SSCreatedDate >= @UpdatedDate




-- Update Vertical Response flags
UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'VerticalResponse'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'VerticalResponse'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneHome
WHERE dc.SourceSystem = 'VerticalResponse'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneBusiness
WHERE dc.SourceSystem = 'VerticalResponse'
AND dc.SSCreatedDate >= @UpdatedDate

UPDATE m
SET m.VerticalResponse = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneFax
WHERE dc.SourceSystem = 'VerticalResponse'
AND dc.SSCreatedDate >= @UpdatedDate




-- Update Hamilton Lottery flags
UPDATE m
SET m.HamiltonLottery = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'Hamilton Lottery'
AND dc.SSCreatedDate >= @UpdatedDate




-- Update Today Tix flags
UPDATE m
SET m.TodayTix = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'Today Tix'
AND dc.SSCreatedDate >= @UpdatedDate




-- Update Survey Monkey flags
UPDATE m
SET m.SurveyMonkey = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneCell
WHERE dc.SourceSystem = 'SurveyMonkey'
AND dc.SSCreatedDate >= @UpdatedDate



-- Update Vivid Seats flags
UPDATE m
SET m.VividSeats = 1
FROM #MasterPhoneList m
JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhonePrimary
WHERE dc.SourceSystem = 'Vivid Seats'
AND dc.SSCreatedDate >= @UpdatedDate





/*========================================================================================================
		Create buckets
========================================================================================================*/
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
INTO #Members
FROM dbo.dimcustomerssbid ssbid (NOLOCK)
JOIN dbo.dimcustomer dc (NOLOCK)
	ON ssbid.DimCustomerId = dc.DimCustomerId
JOIN ods.AV_ts_contact cont (NOLOCK)
	ON dc.SSID = CAST(cont.contact_id AS NVARCHAR(255))
JOIN ods.AV_ts_customer_membership cm (NOLOCK)
	ON cont.contact_parent_id = cm.customermembership_customer_id
JOIN ods.AV_ts_membership m (NOLOCK)
	ON cm.customermembership_membership_id = m.membership_id
WHERE m.membership_description = 'Season 48'



SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
INTO #Buyers
FROM dbo.dimcustomerssbid ssbid (NOLOCK)
JOIN dbo.dimcustomer dc (NOLOCK)
	ON ssbid.DimCustomerId = dc.DimCustomerId
JOIN ods.AV_ts_contact cont (NOLOCK)
	ON dc.SSID = CAST(cont.contact_id AS NVARCHAR(255))
JOIN ods.AV_ts_order ord (NOLOCK)
	ON cont.contact_parent_id = ord.order_customer_id
LEFT JOIN #Members m
	ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID
WHERE m.SSB_CRMSYSTEM_CONTACT_ID IS NULL


SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
INTO #NonBuyers
FROM dbo.dimcustomerssbid ssbid (NOLOCK)
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
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhonePrimary, '') <> ''
AND dc.PhonePrimaryIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneCell Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneCell, '') <> ''
AND dc.PhoneCellIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneHome Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneHome, '') <> ''
AND dc.PhoneHomeIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneBusiness Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneBusiness, '') <> ''
AND dc.PhoneBusinessIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneOther Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneOther, '') <> ''
AND dc.PhoneOtherIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneFax Phone
FROM #Members m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneFax, '') <> ''
AND dc.PhoneFaxIsCleanStatus = 'Valid'



SELECT DISTINCT dc.PhonePrimary Phone
INTO #BuyerPhones
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhonePrimary, '') <> ''
AND dc.PhonePrimaryIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneCell Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneCell, '') <> ''
AND dc.PhoneCellIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneHome Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneHome, '') <> ''
AND dc.PhoneHomeIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneBusiness Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneBusiness, '') <> ''
AND dc.PhoneBusinessIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneOther Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneOther, '') <> ''
AND dc.PhoneOtherIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneFax Phone
FROM #Buyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneFax, '') <> ''
AND dc.PhoneFaxIsCleanStatus = 'Valid'

DELETE
FROM #BuyerPhones
WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)



SELECT DISTINCT dc.PhonePrimary Phone
INTO #NonBuyerPhones
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhonePrimary, '') <> ''
AND dc.PhonePrimaryIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneCell Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneCell, '') <> ''
AND dc.PhoneCellIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneHome Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneHome, '') <> ''
AND dc.PhoneHomeIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneBusiness Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneBusiness, '') <> ''
AND dc.PhoneOtherIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneOther Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneOther, '') <> ''
AND dc.PhonePrimaryIsCleanStatus = 'Valid'
	UNION
SELECT DISTINCT dc.PhoneFax Phone
FROM #NonBuyers m
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
WHERE ISNULL(dc.PhoneFax, '') <> ''
AND dc.PhoneFaxIsCleanStatus = 'Valid'

DELETE
FROM #NonBuyerPhones
WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)

DELETE
FROM #NonBuyerPhones
WHERE Phone IN (SELECT DISTINCT Phone FROM #BuyerPhones)

-- Add Hello World back in
INSERT INTO #NonBuyerPhones (Phone)
SELECT DISTINCT PhoneCell
FROM dbo.DimCustomer dc (NOLOCK)
LEFT JOIN #MemberPhones m
	ON dc.PhoneCell = m.Phone
LEFT JOIN #BuyerPhones b
	ON dc.PhoneCell = b.Phone
LEFT JOIN #NonBuyerPhones n
	ON dc.PhoneCell =  n.Phone
WHERE SourceSystem = 'HelloWorld'
AND dc.PhoneCellIsCleanStatus = 'Valid'
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
LEFT JOIN dbo.DimCustomer dc (NOLOCK)
	ON m.Phone = dc.PhoneCell




/*========================================================================================================
		Load data to materialized table
========================================================================================================*/
TRUNCATE TABLE rpt.MasterPhoneList_Export
INSERT INTO rpt.MasterPhoneList_Export (Phone, AudienceView, HelloWorld, VerticalResponse, SurveyMonkey, HamiltonLottery, TodayTix, VividSeats, Bucket, InPhoneCell, UpdateDate)
SELECT Phone, AudienceView, HelloWorld, VerticalResponse, SurveyMonkey, HamiltonLottery, TodayTix, VividSeats, Bucket, InPhoneCell, GETDATE()
FROM #MasterPhoneList




/*========================================================================================================
		Return materialized table
========================================================================================================*/
SELECT Bucket, Phone, InPhoneCell IdentifiedAsCellPhone
FROM rpt.MasterPhoneList_Export (NOLOCK)
WHERE ISNULL(HelloWorld, '0') = 1
ORDER BY Bucket, IdentifiedAsCellPhone
GO
