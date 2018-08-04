SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [rpt].[PhoneBuckets_AllPhoneNumbers]
AS

/*========================================================================================================================
			Load Buckets
========================================================================================================================*/

				-- Load all distinct Members --
				SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
				INTO #Members
				FROM dbo.dimcustomerssbid ssbid
				JOIN dbo.dimcustomer dc (NOLOCK)
					ON ssbid.DimCustomerId = dc.DimCustomerId
				JOIN ods.AV_ts_contact cont
					ON dc.SSID = CAST(cont.contact_id AS NVARCHAR(255))
				JOIN ods.AV_ts_customer cust
					ON cont.contact_parent_id = cust.customer_id
				JOIN ods.AV_ts_customer_membership cm
					ON cust.customer_id = cm.customermembership_customer_id
				JOIN ods.AV_ts_membership m
					ON cm.customermembership_membership_id = m.membership_id
				WHERE m.membership_description = 'Season 47'


				-- Load all distinct Buyers who are not Members --
				SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
				INTO #Buyers
				FROM dbo.dimcustomerssbid ssbid
				JOIN dbo.dimcustomer dc (NOLOCK)
					ON ssbid.DimCustomerId = dc.DimCustomerId
				JOIN ods.AV_ts_contact cont
					ON dc.SSID = CAST(cont.contact_id AS NVARCHAR(255))
				JOIN ods.AV_ts_customer cust
					ON cont.contact_parent_id = cust.customer_id
				JOIN ods.AV_ts_order ord
					ON cust.customer_id = ord.order_customer_id
				LEFT JOIN #Members m
					ON m.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
				WHERE m.SSB_CRMSYSTEM_CONTACT_ID IS NULL


				-- Load all distinct Non-Buyer, Non-Members --
				SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
				INTO #NonBuyers
				FROM dbo.dimcustomerssbid ssbid
				LEFT JOIN #Members m
					ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID
				LEFT JOIN #Buyers b
					ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
				WHERE m.SSB_CRMSYSTEM_CONTACT_ID IS NULL
				AND b.SSB_CRMSYSTEM_CONTACT_ID IS NULL


/*========================================================================================================================
			Load Bucket phone numbers
========================================================================================================================*/
				-- Pull all distinct phone numbers for members --
				SELECT DISTINCT dc.PhonePrimary Phone
				INTO #MemberPhones
				FROM #Members m
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneCell Phone
				FROM #Members m
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneHome Phone
				FROM #Members m
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneBusiness Phone
				FROM #Members m
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneOther Phone
				FROM #Members m
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneFax Phone
				FROM #Members m
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON m.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'



				-- Pull all distinct phone numbers for buyers --
				SELECT DISTINCT dc.PhonePrimary Phone
				INTO #BuyerPhones
				FROM #Buyers b
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON b.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneCell Phone
				FROM #Buyers b
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON b.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneHome Phone
				FROM #Buyers b
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON b.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneBusiness Phone
				FROM #Buyers b
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON b.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneOther Phone
				FROM #Buyers b
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON b.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneFax Phone
				FROM #Buyers b
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON b.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'

				DELETE 
				FROM #BuyerPhones
				WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)



				-- Pull all distinct phone numbers for non-member non-buyers --
				SELECT DISTINCT dc.PhonePrimary Phone
				INTO #NonBuyerPhones
				FROM #NonBuyers n
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON n.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneCell Phone
				FROM #NonBuyers n
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON n.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneHome Phone
				FROM #NonBuyers n
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON n.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneBusiness Phone
				FROM #NonBuyers n
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON n.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneOther Phone
				FROM #NonBuyers n
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON n.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'
				UNION
				SELECT DISTINCT dc.PhoneFax Phone
				FROM #NonBuyers n
				JOIN dbo.vwDimCustomer_ModAcctId dc
					ON n.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
				WHERE dc.SourceSystem <> 'HelloWorld'


				DELETE 
				FROM #NonBuyerPhones
				WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)


				DELETE 
				FROM #NonBuyerPhones
				WHERE Phone IN (SELECT DISTINCT Phone FROM #BuyerPhones)


/*========================================================================================================================
			Add Hello World to Non-Buyer List
========================================================================================================================*/
				-- Add Hello World back in --
				SELECT DISTINCT PhonePrimary Phone
				INTO #HelloWorld
				FROM dbo.DimCustomer
				WHERE SourceSystem = 'HelloWorld'

				DELETE 
				FROM #HelloWorld
				WHERE Phone IN (SELECT DISTINCT Phone FROM #MemberPhones)

				DELETE 
				FROM #HelloWorld
				WHERE Phone IN (SELECT DISTINCT Phone FROM #BuyerPhones)

				DELETE
				FROM #HelloWorld
				WHERE Phone IN (SELECT DISTINCT Phone FROM #NonBuyerPhones)

				SELECT COUNT(*)
				FROM #HelloWorld

				INSERT INTO #NonBuyerPhones
				SELECT *
				FROM #HelloWorld


/*========================================================================================================================
			Find bucket counts
========================================================================================================================*/
				-- Find Total Counts for each bucket --
				SELECT COUNT(*)
				FROM #MemberPhones

				SELECT COUNT(*)
				FROM #BuyerPhones

				SELECT COUNT(*)
				FROM #NonBuyerPhones


/*========================================================================================================================
			Add SourceSystem data
========================================================================================================================*/
				-- Find Source System counts for each bucket --
				CREATE TABLE #SourceSystemCounts
				(
					  ID					INT IDENTITY(1,1)
					, Bucket				NVARCHAR(255)
					, Phone					NVARCHAR(255)
					, AudienceViewCount		INT
					, HelloWorldCount		INT
					, VerticalResponseCount	INT
					, HamiltonCount			INT
					, SurveyMonkeyCount		INT
					, TodayTixCount			INT
					, VividSeatsCount		INT
				)

				INSERT INTO #SourceSystemCounts (Bucket, Phone)
					SELECT DISTINCT 'Member', Phone
					FROM #MemberPhones
							UNION ALL
					SELECT DISTINCT 'Buyer', Phone
					FROM #BuyerPhones
							UNION ALL
					SELECT DISTINCT 'Non-Buyer', Phone
					FROM #NonBuyerPhones

		-- Build master phone source system list --
				-- Primary --
				SELECT DISTINCT PhonePrimary Phone, SourceSystem
				INTO #Primary
				FROM dbo.DimCustomer
				WHERE ISNULL(PhonePrimary, '') <> ''

				-- Home --
				SELECT DISTINCT PhoneHome Phone, SourceSystem
				INTO #Home
				FROM dbo.DimCustomer
				WHERE ISNULL(PhoneHome, '') <> ''

				-- Cell --
				SELECT DISTINCT PhoneCell Phone, SourceSystem
				INTO #Cell
				FROM dbo.DimCustomer
				WHERE ISNULL(PhoneCell, '') <> ''

				-- Business --
				SELECT DISTINCT PhoneBusiness Phone, SourceSystem
				INTO #Business
				FROM dbo.DimCustomer
				WHERE ISNULL(PhoneBusiness, '') <> ''

				-- Other --
				SELECT DISTINCT PhoneOther Phone, SourceSystem
				INTO #Other
				FROM dbo.DimCustomer
				WHERE ISNULL(PhoneOther, '') <> ''

				-- Fax --
				SELECT DISTINCT PhoneFax Phone, SourceSystem
				INTO #Fax
				FROM dbo.DimCustomer
				WHERE ISNULL(PhoneFax, '') <> ''


				SELECT Phone, SourceSystem
				INTO #PhoneMasterList
				FROM #Primary
				UNION
				SELECT Phone, SourceSystem
				FROM #Cell
				UNION
				SELECT Phone, SourceSystem
				FROM #Home
				UNION
				SELECT Phone, SourceSystem
				FROM #Business
				UNION
				SELECT Phone, SourceSystem
				FROM #Other
				UNION
				SELECT Phone, SourceSystem
				FROM #Fax




				UPDATE s
				SET s.AudienceViewCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'AudienceView'
					) p ON s.Phone = p.Phone

				UPDATE s
				SET s.HelloWorldCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'HelloWorld'
					) p ON s.Phone = p.Phone

				UPDATE s
				SET s.VerticalResponseCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'VerticalResponse'
					) p ON s.Phone = p.Phone

				UPDATE s
				SET s.HamiltonCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'Hamilton Lottery'
					) p ON s.Phone = p.Phone

				UPDATE s
				SET s.SurveyMonkeyCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'SurveyMonkey'
					) p ON s.Phone = p.Phone

				UPDATE s
				SET s.TodayTixCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'Today Tix'
					) p ON s.Phone = p.Phone

				UPDATE s
				SET s.VividSeatsCount = 1
				FROM #SourceSystemCounts s (NOLOCK)
				JOIN (
					SELECT DISTINCT Phone
					FROM #PhoneMasterList
					WHERE SourceSystem = 'Vivid Seats'
					) p ON s.Phone = p.Phone



SELECT Bucket, AudienceViewCount, HelloWorldCount, VerticalResponseCount, HamiltonCount, SurveyMonkeyCount, TodayTixCount, VividSeatsCount
	, COUNT(*)
FROM #SourceSystemCounts
GROUP BY Bucket, AudienceViewCount, HelloWorldCount, VerticalResponseCount, HamiltonCount, SurveyMonkeyCount, TodayTixCount, VividSeatsCount
ORDER BY Bucket, AudienceViewCount DESC, HelloWorldCount DESC, VerticalResponseCount DESC, HamiltonCount DESC, SurveyMonkeyCount DESC, TodayTixCount DESC, VividSeatsCount DESC

SELECT Bucket
	, CONCAT(
		  CASE WHEN AudienceViewCount = 1 THEN 'AudienceView, ' ELSE NULL END
		, CASE WHEN HelloWorldCount = 1 THEN 'HelloWorld, ' ELSE NULL END
		, CASE WHEN VerticalResponseCount = 1 THEN 'VerticalResponse, ' ELSE NULL END
		, CASE WHEN HamiltonCount = 1 THEN 'Hamilton, ' ELSE NULL END
		, CASE WHEN SurveyMonkeyCount = 1 THEN 'SurveyMonkey, ' ELSE NULL END
		, CASE WHEN TodayTixCount = 1 THEN 'TodayTix, ' END
		, CASE WHEN VividSeatsCount = 1 THEN 'VividSeats, ' ELSE NULL END
		) Sources
	, COUNT(*)
FROM #SourceSystemCounts
GROUP BY Bucket, AudienceViewCount, HelloWorldCount, VerticalResponseCount, HamiltonCount, SurveyMonkeyCount, TodayTixCount, VividSeatsCount
ORDER BY Bucket, AudienceViewCount DESC, HelloWorldCount DESC, VerticalResponseCount DESC, HamiltonCount DESC, SurveyMonkeyCount DESC, TodayTixCount DESC, VividSeatsCount DESC

GO
