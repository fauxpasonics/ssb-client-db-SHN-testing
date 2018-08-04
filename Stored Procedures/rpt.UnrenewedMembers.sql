SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [rpt].[UnrenewedMembers]
AS

SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
	, CASE WHEN COALESCE(m.membership_description, m.membership_name) LIKE '%Season 39%' THEN 'Season 39'
		WHEN COALESCE(m.membership_description, m.membership_name) LIKE '%Season 40%' THEN 'Season 40'
		ELSE COALESCE(m.membership_description, m.membership_name) END AS membership_description
INTO #AllMemberships
FROM ods.AV_ts_customer_membership cm (NOLOCK)
JOIN ods.AV_ts_customer cust (NOLOCK)
	ON cm.customermembership_customer_id = cust.customer_id
JOIN ods.AV_ts_membership m (NOLOCK)
	ON cm.customermembership_membership_id = m.membership_id
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON cust.customer_default_contact_id = ssbid.SSID
	AND ssbid.SourceSystem = 'AV'
WHERE ISNULL(m.membership_description, '') NOT IN ('', 'Group Offer Online')



SELECT *
INTO #Season47
FROM #AllMemberships
WHERE membership_description = 'Season 47'

SELECT *
INTO #Season48
FROM #AllMemberships
WHERE membership_description = 'Season 48'


SELECT a.SSB_CRMSYSTEM_CONTACT_ID, cr.FirstName, cr.LastName, cr.EmailPrimary, cr.PhonePrimary
	, cr.AddressPrimaryStreet, cr.AddressPrimaryCity, dc.AccountId CustomerNumber
FROM #Season47 a
LEFT JOIN #Season48 b
	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
JOIN mdm.compositerecord cr
	ON a.SSB_CRMSYSTEM_CONTACT_ID = cr.SSB_CRMSYSTEM_CONTACT_ID
JOIN (
		SELECT SSB_CRMSYSTEM_CONTACT_ID
			, AccountId
			, RANK() OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID ORDER BY CreatedDate DESC, UpdatedDate DESC, DimCustomerId) xRank
		FROM dbo.vwDimCustomer_ModAcctId
		WHERE SourceSystem = 'AV'
		AND AccountId IS NOT null
	) dc ON cr.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID
		AND dc.xRank = 1
WHERE b.SSB_CRMSYSTEM_CONTACT_ID IS NULL
ORDER BY dc.AccountId

GO
