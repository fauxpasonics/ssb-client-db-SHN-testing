SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [rpt].[Get_AVNonMembersNotInVR] (@UpdatedDate DATE)
AS

--DECLARE @UpdatedDate DATE = ''

SET @UpdatedDate = CASE WHEN ISNULL(@UpdatedDate, '') = '' THEN CAST((GETDATE() - 7) AS DATE) ELSE @UpdatedDate END


SELECT SSB_CRMSYSTEM_CONTACT_ID, FirstName, LastName, dc.EmailPrimary, dc.PhonePrimary
	, dc.AddressPrimaryStreet, dc.AddressPrimaryCity, dc.AddressPrimaryState, dc.AddressPrimaryZip, ssid ContactID, dc.CreatedDate, dc.UpdatedDate
INTO #AVbuyers
FROM dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
WHERE SourceSystem = 'AV'
AND dc.EmailPrimaryIsCleanStatus = 'Valid'
AND dc.CreatedDate >= @UpdatedDate


SELECT DISTINCT cont.contact_id
INTO #Members
FROM ods.AV_ts_contact cont (NOLOCK)
JOIN ods.AV_ts_customer cust (NOLOCK)
	ON cust.customer_id = cont.contact_parent_id
JOIN ods.AV_ts_customer_membership custmem (NOLOCK)
	ON cust.customer_id = custmem.customermembership_customer_id
JOIN ods.AV_ts_membership mem (NOLOCK)
	ON custmem.customermembership_membership_id = mem.membership_id
WHERE mem.membership_description IN ('Season 47', 'Season 48 New', 'Season 48 Renew')


SELECT SSB_CRMSYSTEM_CONTACT_ID, FirstName, LastName, dc.EmailPrimary, dc.PhonePrimary
	, dc.AddressPrimaryStreet, dc.AddressPrimaryCity, dc.AddressPrimaryState, dc.AddressPrimaryZip, ssid ContactIDl, dc.CreatedDate, dc.UpdatedDate
INTO #VerticalResponse
FROM dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
WHERE SourceSystem = 'VerticalResponse'


SELECT a.*
INTO #NetNew
FROM #AVbuyers a
LEFT JOIN #Members m
	ON a.ContactID = m.contact_id
LEFT JOIN #VerticalResponse v
	ON a.SSB_CRMSYSTEM_CONTACT_ID = v.SSB_CRMSYSTEM_CONTACT_ID
WHERE m.contact_id IS NULL
	AND v.SSB_CRMSYSTEM_CONTACT_ID IS null


SELECT DISTINCT n.SSB_CRMSYSTEM_CONTACT_ID, n.FirstName, n.LastName, n.EmailPrimary, n.PhonePrimary, REPLACE(REPLACE(n.AddressPrimaryStreet, CHAR(13), ' '), CHAR(10), ' ') AddressPrimaryStreet, n.AddressPrimaryCity
	, n.AddressPrimaryState, n.AddressPrimaryZip, n.ContactID, n.CreatedDate, n.UpdatedDate
FROM #NetNew n
LEFT JOIN #VerticalResponse v
	ON n.EmailPrimary = v.EmailPrimary
WHERE v.EmailPrimary IS null
ORDER BY n.UpdatedDate
--271768


GO
