SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[Load_Contact_CustomFields]
AS

DECLARE @CurrentSeason NVARCHAR(255) = '''Season 48 New'', ''Season 48 Renew'''
DECLARE @PYSeason NVARCHAR(255) = 'Season 47'

-- Load new SSB GUIDs --
INSERT INTO dbo.Contact_CustomFields (SSB_CRMSYSTEM_CONTACT_ID)
SELECT DISTINCT cr.SSB_CRMSYSTEM_CONTACT_ID
FROM mdm.compositerecord cr (NOLOCK)
LEFT JOIN dbo.Contact_CustomFields ccf (NOLOCK)
	ON cr.SSB_CRMSYSTEM_CONTACT_ID = ccf.SSB_CRMSYSTEM_CONTACT_ID
WHERE ccf.SSB_CRMSYSTEM_CONTACT_ID IS NULL

DELETE FROM dbo.Contact_CustomFields
WHERE SSB_CRMSYSTEM_CONTACT_ID NOT IN (SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID FROM mdm.compositerecord)


-- PrimaryCustomer Number --
UPDATE a
SET a.PrimaryCustomerNumber = ISNULL(b.Customer_Number, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, ssbid.SSB_CRMSYSTEM_PRIMARY_FLAG, MaxPurchase.customer_number, MaxPurchase.MaxPurchaseDate
			, RANK() OVER(PARTITION BY ssbid.SSB_CRMSYSTEM_CONTACT_ID ORDER BY ssbid.SSB_CRMSYSTEM_PRIMARY_FLAG DESC, MaxPurchase.MaxPurchaseDate) xRank
		FROM (
				SELECT cust.customer_id, cust.customer_number, cust.customer_default_contact_id, MAX(ordaud.timestamp) MaxPurchaseDate
				FROM ods.AV_ts_customer cust (NOLOCK)
				LEFT JOIN ods.AV_ts_order ord (NOLOCK)
					ON cust.customer_id = ord.order_customer_id
				LEFT JOIN ods.AV_ts_order_audit ordaud (NOLOCK)
					ON ord.order_audit_id = ordaud.order_create_audit_id
				GROUP BY cust.customer_id, cust.customer_number, cust.customer_default_contact_id
			) MaxPurchase
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON MaxPurchase.customer_default_contact_id = dc.SSID AND dc.SourceSystem = 'AV'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID AND b.xRank = 1


-- AllCustomerNumbers --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, CAST(cust.customer_number AS NVARCHAR(100)) customer_number
INTO #CustomerNumbers
FROM ods.AV_ts_customer cust (NOLOCK)
JOIN dbo.DimCustomer dc (NOLOCK)
	ON cust.customer_default_contact_id = dc.SSID AND dc.SourceSystem = 'AV'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId

UPDATE a
SET a.AllCustomerNumbers = ISNULL(d.CustomerNumber, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT b.SSB_CRMSYSTEM_CONTACT_ID,
		SUBSTRING(
		(
			SELECT ',' + a.customer_number AS [text()]
			FROM #CustomerNumbers a
			WHERE a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
			ORDER BY a.SSB_CRMSYSTEM_CONTACT_ID
			FOR XML PATH ('')
		), 2, 1000) CustomerNumber
	FROM #CustomerNumbers b
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- AreaCode --
UPDATE a
SET a.AreaCode = ISNULL(SUBSTRING(cr.PhonePrimary, 2, 3), '')
FROM dbo.Contact_CustomFields a
JOIN mdm.compositerecord cr (NOLOCK)
	ON cr.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID
	AND cr.PhonePrimaryIsCleanStatus = 'Valid'


-- IsSF --
UPDATE a
SET a.IsSF = CASE WHEN ISNULL(cr.AddressPrimaryCity, '') = 'San Francisco' THEN 1 ELSE 0 END
FROM dbo.Contact_CustomFields a
JOIN mdm.compositerecord cr (NOLOCK)
	ON cr.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- IsBayArea --
UPDATE a
SET a.IsBayArea = CASE WHEN ISNULL(cr.AddressPrimaryCounty, '') IN ('San Francisco', 'Alameda'
					, 'Santa Clara', 'Contra Costa', 'San Mateo', 'Marin'
					, 'Sonoma', 'Solano', 'Napa', 'Sacramento')
				THEN 1 ELSE 0 END
FROM dbo.Contact_CustomFields a
JOIN mdm.compositerecord cr (NOLOCK)
	ON cr.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- IsNorCal --
UPDATE a
SET a.IsNorCal = CASE WHEN ISNULL(cr.AddressPrimaryCounty, '') IN ('Alpine', 'Amador'
						, 'Butte', 'Calaveras', 'Colusa', 'Del Norte', 'El Dorado'
						, 'Fresno', 'Glenn', 'Humboldt', 'Inyo', 'Kings', 'Lake', 'Lassen'
						, 'Madera', 'Mariposa', 'Mendocino', 'Merced', 'Modoc', 'Mono', 'Monterey'
						, 'Nevada', 'Placer', 'Plumas', 'Sacramento', 'San Benito', 'San Joaquin'
						, 'Santa Cruz', 'Shasta', 'Stanislaus', 'Siskiyou', 'Stanislaus', 'Sutter'
						, 'Tehama', 'Trinity', 'Tulare', 'Tuolumne', 'Yolo', 'Yuba')
				THEN 1 ELSE 0 END
FROM dbo.Contact_CustomFields a
JOIN mdm.compositerecord cr (NOLOCK)
	ON cr.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- IsCurrentMember --
UPDATE a
SET a.IsCurrentMember = ISNULL(b.IsCurrentMember, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 IsCurrentMember
	FROM ods.AV_ts_customer_membership cm (NOLOCK)
	JOIN ods.AV_ts_customer cust (NOLOCK)
		ON cm.customermembership_customer_id = cust.customer_id
	JOIN ods.AV_ts_membership m (NOLOCK)
		ON cm.customermembership_membership_id = m.membership_id
	JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
		ON cust.customer_default_contact_id = ssbid.SSID
		AND ssbid.SourceSystem = 'AV'
	WHERE m.membership_description IN (@CurrentSeason)
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID



-- IsPriorMember --
UPDATE a
SET a.IsPriorMember = ISNULL(b.IsPriorMember, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 IsPriorMember
	FROM ods.AV_ts_customer_membership cm (NOLOCK)
	JOIN ods.AV_ts_customer cust (NOLOCK)
		ON cm.customermembership_customer_id = cust.customer_id
	JOIN ods.AV_ts_membership m (NOLOCK)
		ON cm.customermembership_membership_id = m.membership_id
	JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
		ON cust.customer_default_contact_id = ssbid.SSID
		AND ssbid.SourceSystem = 'AV'
	WHERE m.membership_description = @PYSeason
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID




-- FirstMembershipSeason --
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

UPDATE a
SET a.FirstMembershipSeason = ISNULL(m.membership_description, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT m.SSB_CRMSYSTEM_CONTACT_ID, m.membership_description
		, RANK() OVER(PARTITION BY m.SSB_CRMSYSTEM_CONTACT_ID ORDER BY m.membership_description) xRank
	FROM #AllMemberships m
	) m ON a.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID AND m.xRank = 1


-- LastMembershipSeason --
UPDATE a
SET a.LastMembershipSeason = ISNULL(m.membership_description, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT m.SSB_CRMSYSTEM_CONTACT_ID, m.membership_description
		, RANK() OVER(PARTITION BY m.SSB_CRMSYSTEM_CONTACT_ID ORDER BY m.membership_description DESC) xRank
	FROM #AllMemberships m
	) m ON a.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID AND m.xRank = 1


-- AllMembershipSeasons --
UPDATE a
SET a.MembershipSeasons = ISNULL(d.Memberships, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT b.SSB_CRMSYSTEM_CONTACT_ID,
		SUBSTRING(
			(
				SELECT ',' + a.membership_description AS [text()]
				FROM #AllMemberships a
				WHERE a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
				ORDER BY a.SSB_CRMSYSTEM_CONTACT_ID
				FOR XML PATH ('')
			), 2, 1000) Memberships
	FROM #AllMemberships b
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- IsActive --
UPDATE a
SET a.IsActive = ISNULL(b.IsActive, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 IsActive
	FROM dbo.FactTicketSales_V2 f (NOLOCK)
	JOIN dbo.DimEvent_V2 perf (NOLOCK)
		ON f.DimEventId = perf.DimEventId
	JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
		ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
	JOIN dbo.dimcustomer dc (NOLOCK)
		ON dtc.CustomerId = dc.ssid
		AND dc.SourceSystem = 'AV'
		AND dc.CustomerStatus = 'Primary'
	JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
		ON dc.DimCustomerId = ssbid.DimCustomerId
	WHERE perf.EventDate >= (GETDATE() - 730)
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- FirstShow, FirstPerformance --
SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, MIN(perf.EventDateTime) MinEventDate
	, MAX(CASE WHEN perf.EventDateTime < GETDATE() THEN perf.EventDateTime ELSE '1900-01-01 00:00:00.000' END) AS LastEventDate
	, MIN(CASE WHEN perf.EventDateTime >= GETDATE() THEN perf.EventDateTime ELSE '9999-12-31 00:00:00.000' END) AS NextEventDate
INTO #PerformanceDates
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
JOIN dbo.dimcustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID


UPDATE a
SET a.FirstSeries = ISNULL(b.SeriesName, '')
	, a.FirstPerformance = ISNULL(b.PerformanceName, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, series.EventName SeriesName, perf.EventCode AS PerformanceName, perf.EventDateTime
			, RANK() OVER(PARTITION BY pd.SSB_CRMSYSTEM_CONTACT_ID ORDER BY series.EventName) xRank
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
		JOIN dbo.dimcustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN dbo.DimEventHeader_V2 series (NOLOCK)
			ON perf.AV_series_id = series.ETL__SSID_AV_series_id
		JOIN #PerformanceDates pd (NOLOCK)
			ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = pd.SSB_CRMSYSTEM_CONTACT_ID
			AND perf.EventDateTime = pd.MinEventDate
		WHERE series.EventName NOT IN ('AudioVision')
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID AND b.xRank = 1


-- MostRecentShow, MostRecentPerformance --
UPDATE a
SET a.MostRecentSeries = ISNULL(b.SeriesName, '')
	, a.MostRecentPerformance = ISNULL(b.PerformanceName, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, series.EventName SeriesName, perf.EventCode AS PerformanceName, perf.EventDateTime
			, RANK() OVER(PARTITION BY pd.SSB_CRMSYSTEM_CONTACT_ID ORDER BY series.EventName) xRank
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
		JOIN dbo.dimcustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN dbo.DimEventHeader_V2 series (NOLOCK)
			ON perf.AV_series_id = series.ETL__SSID_AV_series_id
		JOIN #PerformanceDates pd (NOLOCK)
			ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = pd.SSB_CRMSYSTEM_CONTACT_ID
			AND perf.EventDateTime = pd.LastEventDate
		WHERE series.EventName NOT IN ('AudioVision')
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID AND b.xRank = 1


-- NextUpcomingShow, NextUpcomingPerformance --
UPDATE a
SET a.NextUpcomingSeries = ISNULL(b.SeriesName, '')
	, a.NextUpcomingPerformance = ISNULL(b.PerformanceName, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, series.EventName SeriesName, perf.EventCode AS PerformanceName, perf.EventDateTime
			, RANK() OVER(PARTITION BY pd.SSB_CRMSYSTEM_CONTACT_ID ORDER BY series.EventName) xRank
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
		JOIN dbo.dimcustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN dbo.DimEventHeader_V2 series (NOLOCK)
			ON perf.AV_series_id = series.ETL__SSID_AV_series_id
		JOIN #PerformanceDates pd (NOLOCK)
			ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = pd.SSB_CRMSYSTEM_CONTACT_ID
			AND perf.EventDateTime = pd.NextEventDate
		WHERE series.EventName NOT IN ('AudioVision')
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID AND b.xRank = 1


-- AllSeries --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, series.DimEventHeaderId
	, COALESCE(series.EventName, series.EventDesc) Series, series.EventOpenTime, series.EventFinishTime
	, series.AV_series_data1, series.AV_series_data2, series.AV_series_data4, series.AV_series_data5
INTO #AllSeries
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
JOIN dbo.DimEventHeader_V2 series (NOLOCK)
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
JOIN dbo.dimcustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
WHERE ISNULL(COALESCE(series.EventName, series.EventDesc), '') <> ''
	AND COALESCE(series.EventName, series.EventDesc) <> 'AudioVision'
	AND COALESCE(series.EventName, series.EventDesc) NOT LIKE '%master'

UPDATE a
SET a.AllSeries = ISNULL(d.AllSeries, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT b.SSB_CRMSYSTEM_CONTACT_ID,
		SUBSTRING(
			(
				SELECT ',' + a.Series AS [text()]
				FROM #AllSeries a (NOLOCK)
				WHERE a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
				ORDER BY a.SSB_CRMSYSTEM_CONTACT_ID
				FOR XML PATH ('')
			), 2, 1000) AllSeries
	FROM #AllSeries b
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- CountCYSeries --
UPDATE a
SET a.CountCYSeries = ISNULL(d.SeriesCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT b.SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) SeriesCount
	FROM #AllSeries b (NOLOCK)
	WHERE b.EventOpenTime >= (GETDATE() - 365)
		OR b.EventFinishTime >= (GETDATE() - 365)
	GROUP BY b.SSB_CRMSYSTEM_CONTACT_ID
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- CountPYSeries --
UPDATE a
SET a.CountPYSeries = ISNULL(d.SeriesCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT b.SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) SeriesCount
	FROM #AllSeries b (NOLOCK)
	WHERE (b.EventOpenTime < (GETDATE() - 365) AND b.EventOpenTime >= (GETDATE() - 730))
		OR (b.EventFinishTime < (GETDATE() - 365) AND b.EventFinishTime >= (GETDATE() - 730))
	GROUP BY b.SSB_CRMSYSTEM_CONTACT_ID
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- CountTotalSeries --
UPDATE a
SET a.CountTotalSeries = ISNULL(d.SeriesCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT b.SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) SeriesCount
	FROM #AllSeries b (NOLOCK)
	GROUP BY b.SSB_CRMSYSTEM_CONTACT_ID
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- CountCYPerformances --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, perf.DimEventId
	, COALESCE(perf.EventName, perf.EventDesc, perf.EventCode) Performance, perf.EventDateTime
	, series.AV_series_data1, series.AV_series_data2, series.AV_series_data4, series.AV_series_data5, series.AV_series_group
INTO #AllPerformances
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
JOIN dbo.DimEventHeader_V2 series (NOLOCK)
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
JOIN dbo.dimcustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
WHERE ISNULL(COALESCE(series.EventName, series.EventDesc), '') <> ''
	AND COALESCE(series.EventName, series.EventDesc) <> 'AudioVision'
	AND COALESCE(series.EventName, series.EventDesc) NOT LIKE '%master'

UPDATE a
SET a.CountCYPerformances = ISNULL(d.PerformanceCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT b.SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) PerformanceCount
	FROM #AllPerformances b (NOLOCK)
	WHERE b.EventDateTime >= (GETDATE() - 365)
	GROUP BY b.SSB_CRMSYSTEM_CONTACT_ID
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID



-- CountPYPerformances --
UPDATE a
SET a.CountPYPerformances = ISNULL(d.PerformanceCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT b.SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) PerformanceCount
	FROM #AllPerformances b (NOLOCK)
	WHERE b.EventDateTime < (GETDATE() - 365) AND b.EventDateTime >= (GETDATE() - 730)
	GROUP BY b.SSB_CRMSYSTEM_CONTACT_ID
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- CountTotalPerformances --
UPDATE a
SET a.CountTotalPerformances = ISNULL(d.PerformanceCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT b.SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) PerformanceCount
	FROM #AllPerformances b (NOLOCK)
	GROUP BY b.SSB_CRMSYSTEM_CONTACT_ID
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- LifetimeValue --
SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, perf.DimEventId, COALESCE(perf.EventName, perf.EventDesc, perf.EventCode) Performance
	, perf.EventDateTime, SUM(f.RevenueTotal) TotalRevenue
INTO #Spend
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
JOIN dbo.dimcustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID, perf.DimEventId, COALESCE(perf.EventName, perf.EventDesc, perf.EventCode)
	, perf.EventDateTime

UPDATE a
SET a.LifetimeValue = ISNULL(b.TotalRevenue, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(TotalRevenue) TotalRevenue
	FROM #Spend (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- CYSpend --
UPDATE a
SET a.CYSpend = ISNULL(b.TotalRevenue, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(TotalRevenue) TotalRevenue
	FROM #Spend (NOLOCK)
	WHERE EventDateTime >= (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- PYSpend --
UPDATE a
SET a.PYSpend = ISNULL(b.TotalRevenue, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(TotalRevenue) TotalRevenue
	FROM #Spend (NOLOCK)
	WHERE EventDateTime < (GETDATE() - 365) AND EventDateTime >= (GETDATE() - 730)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- AvgTicketsPerPerformance --
SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, perf.DimEventId, COALESCE(perf.EventName, perf.EventDesc, perf.EventCode) Performance
	, perf.EventDateTime, SUM(f.QtySeat) TotalTickets
INTO #Tickets
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
JOIN dbo.dimcustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID, perf.DimEventId, COALESCE(perf.EventName, perf.EventDesc, perf.EventCode)
	, perf.EventDateTime

UPDATE a
SET a.AvgTicketsPerPerformance = (CASE WHEN ISNULL(b.TotalPerformances, 0) <> 0 THEN b.TotalTickets/b.TotalPerformances ELSE 0 END)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT Performance) TotalPerformances, SUM(TotalTickets) TotalTickets
	FROM #Tickets (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- TotalTickets --
UPDATE a
SET a.TotalTickets = ISNULL(b.TotalTickets, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(TotalTickets) TotalTickets
	FROM #Tickets (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- CYTickets --
UPDATE a
SET a.CYTickets = ISNULL(b.TotalTickets, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(TotalTickets) TotalTickets
	FROM #Tickets (NOLOCK)
	WHERE EventDateTime >= (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- PYTickets --
UPDATE a
SET a.PYTickets = ISNULL(b.TotalTickets, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(TotalTickets) TotalTickets
	FROM #Tickets (NOLOCK)
	WHERE EventDateTime < (GETDATE() - 365) AND EventDateTime >= (GETDATE() - 730)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- IsHamiltonBuyer --
UPDATE a
SET a.IsHamiltonBuyer = ISNULL(b.IsBuyer, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 IsBuyer
	FROM dbo.FactTicketSales_V2 f (NOLOCK)
	JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
		ON f.ETL__SSID_AV_customer_id = dtc.ETL__SSID_AV_customer_id
	JOIN dbo.DimCustomer dc (NOLOCK)
		ON dtc.CustomerId = dc.SSID
		AND dc.SourceSystem = 'AV'
		AND dc.CustomerStatus = 'Primary'
	JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
		ON dc.DimCustomerId = ssbid.DimCustomerId
	JOIN dbo.DimEvent_V2 perf (NOLOCK)
		ON f.DimEventId = perf.DimEventId
	JOIN dbo.DimEventHeader_V2 series (NOLOCK)
		ON perf.AV_series_id = series.ETL__SSID_AV_series_id
	WHERE series.EventName = 'Hamilton'
	) b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID


-- IsTodayTixBuyer --
SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID, SourceSystem
INTO #SourceSystems
FROM dbo.dimcustomerssbid

UPDATE a
SET a.IsTodayTixBuyer = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'Today Tix' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- IsHamiltonLotteryBuyer --
UPDATE a
SET a.IsHamiltonLotteryBuyer = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'Hamilton Lottery' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VREmailLists --
SELECT DISTINCT dc.SSB_CRMSYSTEM_CONTACT_ID, l.[Name] ListName
INTO #SubscriberLists
FROM ods.VerticalResponse_ListMembers lm (NOLOCK)
JOIN ods.VerticalResponse_Lists l (NOLOCK)
	ON lm.ListID = l.ListID
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON lm.CID = dc.SSID
	AND dc.SourceSystem = 'VerticalResponse'


UPDATE a
SET a.VREmailLists = ISNULL(d.SubscriberLists, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT b.SSB_CRMSYSTEM_CONTACT_ID,
		SUBSTRING(
			(
				SELECT ',' + a.ListName AS [text()]
				FROM #SubscriberLists a (NOLOCK)
				WHERE a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
				ORDER BY a.SSB_CRMSYSTEM_CONTACT_ID
				FOR XML PATH ('')
			), 2, 1000) SubscriberLists
	FROM #SubscriberLists b
	) d ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID


-- VRLastEmailReceived --
SELECT DISTINCT dc.SSB_CRMSYSTEM_CONTACT_ID, ecr.List_Name, ecr.Response_Date UnsubDate
INTO #Unsubscribes
FROM ods.VerticalResponse_EmailCampaign_Recipients ecr (NOLOCK)
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON ecr.Email_Address = dc.EmailPrimary
	AND dc.SourceSystem = 'VerticalResponse'
WHERE ecr.Response_Type = 'Unsubscribe'

SELECT DISTINCT dc.SSB_CRMSYSTEM_CONTACT_ID, ec.CampaignID, ec.MailDate
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

SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(MailDate) MaxMailDate
INTO #MaxMailing
FROM #Deliveries (NOLOCK)
GROUP BY SSB_CRMSYSTEM_CONTACT_ID

UPDATE a
SET a.VRLastEmailReceived = ec.[Name]
FROM dbo.Contact_CustomFields a
JOIN #MaxMailing m (NOLOCK)
	ON a.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID
JOIN #Deliveries d (NOLOCK)
	ON m.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID
	AND m.MaxMailDate = d.MailDate
JOIN ods.VerticalResponse_EmailCampaigns ec (NOLOCK)
	ON d.CampaignID = ec.CampaignID


-- VREmailOpenPct --
SELECT dc.SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT cr.ETL__multi_query_value_for_audit) OpenedCampaigns
INTO #Opens
FROM ods.VerticalResponse_EmailCampaign_Recipients ecr (NOLOCK)
JOIN apietl.VerticalResponse_CampaignRecipients_FileNames cr (NOLOCK)
	ON ecr.ETL__Source = cr.ETL__DestinationFileName
JOIN dbo.vwDimCustomer_ModAcctId dc (NOLOCK)
	ON ecr.Email_Address = dc.EmailPrimary
	AND dc.SourceSystem = 'VerticalResponse'
WHERE ecr.Response_Type = 'Open'
GROUP BY dc.SSB_CRMSYSTEM_CONTACT_ID

SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT CampaignID) DeliveredCampaigns
INTO #Delivered
FROM #Deliveries
GROUP BY SSB_CRMSYSTEM_CONTACT_ID

UPDATE a
SET a.VREmailOpenPcnt = CASE WHEN ISNULL(b.Deliveries, 0) <> 0 THEN (b.Opens/b.Deliveries)*100
							 WHEN ISNULL(b.Deliveries, 0) = 0 THEN NULL END
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT d.SSB_CRMSYSTEM_CONTACT_ID
			, CAST(d.DeliveredCampaigns AS DECIMAL(10,2)) Deliveries
			, CAST(ISNULL(o.OpenedCampaigns, 0) AS DECIMAL(10,2)) Opens
		FROM #Delivered d (NOLOCK)
		LEFT JOIN #Opens o (NOLOCK)
			ON d.SSB_CRMSYSTEM_CONTACT_ID = o.SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- AVEmailLists --


-- MostCommonShowType --
SELECT SSB_CRMSYSTEM_CONTACT_ID, AV_series_data2 ShowType, COUNT(*) ShowCount
	, RANK() OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID ORDER BY COUNT(*) DESC) xRank
INTO #ShowTypeRanks
FROM #AllPerformances (NOLOCK)
GROUP BY SSB_CRMSYSTEM_CONTACT_ID, AV_series_data2

UPDATE a
SET a.MostCommonShowType = ISNULL(Rankings.ShowType, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT a.SSB_CRMSYSTEM_CONTACT_ID, a.ShowType, a.ShowCount, a.xRank
	FROM #ShowTypeRanks a (NOLOCK)
	JOIN (
		SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) TopRankCount
		FROM #ShowTypeRanks (NOLOCK)
		WHERE xRank = 1
		GROUP BY #ShowTypeRanks.SSB_CRMSYSTEM_CONTACT_ID
		HAVING COUNT(*) = 1
		) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
	WHERE a.xRank = 1
	) Rankings ON a.SSB_CRMSYSTEM_CONTACT_ID = Rankings.SSB_CRMSYSTEM_CONTACT_ID


-- NCOAStatus --
UPDATE a
SET a.NCOAStatus = ISNULL(cr.AddressPrimaryNCOAStatus, 0)
FROM dbo.Contact_CustomFields a (NOLOCK)
JOIN mdm.compositerecord cr (NOLOCK)
	ON a.SSB_CRMSYSTEM_CONTACT_ID = cr.SSB_CRMSYSTEM_CONTACT_ID


-- SubscriptionShows --
UPDATE a
SET a.SubscriptionShows = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data1 = 'Subscription'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- NonSubscriptionShows --
UPDATE a
SET a.NonSubscriptionShows = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data1 = 'Non-Subscription'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- RepeatShows --
UPDATE a
SET a.RepeatShows = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data4 = 'Repeat'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- PremiereShows --
UPDATE a
SET a.PremiereShows = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data4 = 'Premiere'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Musicals --
UPDATE a
SET a.MusicalShows = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Musical'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


	
-- Plays --
UPDATE a
SET a.Plays = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Play'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Events --
UPDATE a
SET a.[Events] = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Event'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Concerts --
UPDATE a
SET a.Concerts = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Concert'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Lectures --
UPDATE a
SET a.Lectures = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Lecture'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Conversations --
UPDATE a
SET a.Conversations = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Conversation'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- SpecialEngagements --
UPDATE a
SET a.SpecialEngagements = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_data5 = 'Special Engagement'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- SingleShows --
UPDATE a
SET a.SingleShows = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Single'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season39 --
UPDATE a
SET a.Season39 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 39'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season40 --
UPDATE a
SET a.Season40 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 40'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season41 --
UPDATE a
SET a.Season41 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 41'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season42 --
UPDATE a
SET a.Season42 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 42'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season43 --
UPDATE a
SET a.Season43 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 43'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season44 --
UPDATE a
SET a.Season44 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 44'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season45 --
UPDATE a
SET a.Season45 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 45'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season46 --
UPDATE a
SET a.Season46 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 46'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Season47 --
UPDATE a
SET a.Season47 = ISNULL(b.RecordCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) RecordCount
	FROM #AllPerformances (NOLOCK)
	WHERE AV_series_group = 'Season 47'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InHelloWorld --
UPDATE a
SET a.InHelloWorld = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'HelloWorld' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InHamilton --
UPDATE a
SET a.InHamilton = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'Hamilton Lottery' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InTodayTix --
UPDATE a
SET a.InTodayTix = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'Today Tix' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InAudienceView --
UPDATE a
SET a.InAudienceView = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'AV' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InVerticalResponse --
UPDATE a
SET a.InVerticalResponse = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'VerticalResponse' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InVividSeats --
UPDATE a
SET a.InVividSeats = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'Vivid Seats' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- InSurveyMonkey --
UPDATE a
SET a.InSurveyMonkey = ISNULL(b.ExistsInSource, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MAX(CASE WHEN SourceSystem = 'SurveyMonkey' THEN 1 ELSE 0 END) AS ExistsInSource
	FROM #SourceSystems (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- TotalYearsAsMember --
UPDATE a
SET a.TotalYearsAsMember = ISNULL(b.SeasonCount, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(*) SeasonCount
	FROM #AllMemberships (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- FirstTimeBuyer --
UPDATE a
SET a.FirstTimeBuyer = (CASE WHEN b.MinEventDate >= (GETDATE() - 365) THEN 1 ELSE 0 END)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, MIN(EventDateTime) MinEventDate
	FROM #AllPerformances (NOLOCK)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- FirstTimeMember --
UPDATE a
SET a.FirstTimeMember = ISNULL(b.FirstTimeMember, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID, 1 FirstTimeMember
	FROM dbo.Contact_CustomFields (NOLOCK)
	WHERE TotalYearsAsMember = 1 AND IsCurrentMember = 1
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID



-- TodayTixCYSeries --
SELECT DISTINCT a.SourceSystem, a.SSB_CRMSYSTEM_CONTACT_ID
	,attr.value('( order_date/text())[1]',  'varchar(max)') as OrderDate
	,attr.value('( series_name/text())[1]',  'varchar(max)') as SeriesName
	,attr.value('( performance_date/text())[1]',  'varchar(max)') as PerformanceDate
	,attr.value('( section/text())[1]',  'varchar(max)') as Section
	,attr.value('( row/text())[1]',  'varchar(max)') as [Row]
	,attr.value('( admission_count/text())[1]',  'varchar(max)') as AdmissionCount
	, t.CreatedDate
	, t.UpdatedDate
INTO #ThirdPartyTicketSales -- used for vivid seats as well
FROM dbo.vwDimCustomer_ModAcctId a (NOLOCK)
JOIN dbo.dimcustomerattributes t (NOLOCK)
	CROSS APPLY attributes.nodes('dimcustomerattributes') AS Attributes(attr) 
	ON a.dimcustomerid = t.dimcustomerid


UPDATE a
SET a.TodayTixCYSeries = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT SeriesName) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Today Tix'
		AND CAST(UpdatedDate AS DATE) >= (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- TodayTixPYSeries --
UPDATE a
SET a.TodayTixPYSeries = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT SeriesName) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Today Tix'
		AND CAST(UpdatedDate AS DATE) >= (GETDATE() - 730)
		AND CAST(UpdatedDate AS DATE) < (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- TodayTixTotalSeries --
UPDATE a
SET a.TodayTixTotalSeries = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT SeriesName) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Today Tix'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VividSeatsCYPerformances --
UPDATE a
SET a.VividSeatsCYPerformances = ISNULL(b.DistinctPerformances, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT CONCAT(SeriesName,PerformanceDate)) DistinctPerformances
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Vivid Seats'
		AND CAST(PerformanceDate AS DATE) >= (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VividSeatsCYSeries --
UPDATE a
SET a.VividSeatsCYSeries = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT SeriesName) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Vivid Seats'
		AND CAST(PerformanceDate AS DATE) >= (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VividSeatsPYPerformances --
UPDATE a
SET a.VividSeatsPYPerformances = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT CONCAT(SeriesName, PerformanceDate)) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Vivid Seats'
		AND CAST(PerformanceDate AS DATE) >= (GETDATE() - 730)
		AND CAST(PerformanceDate AS DATE) < (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VividSeatsPYSeries --
UPDATE a
SET a.VividSeatsPYSeries = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT SeriesName) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Vivid Seats'
		AND CAST(PerformanceDate AS DATE) >= (GETDATE() - 730)
		AND CAST(PerformanceDate AS DATE) < (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VividSeatsTotalPerformances --
UPDATE a
SET a.VividSeatsTotalPerformances = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT CONCAT(SeriesName, PerformanceDate)) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Vivid Seats'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- VividSeatsTotalSeries --
UPDATE a
SET a.VividSeatsTotalSeries = ISNULL(b.DistinctSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT SeriesName) DistinctSeries
	FROM #ThirdPartyTicketSales
	WHERE SourceSystem = 'Vivid Seats'
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- IsOlderMember --
UPDATE dbo.Contact_CustomFields
SET IsOlderMember = CASE WHEN ISNULL(MembershipSeasons, '') <> '' AND ISNULL(IsCurrentMember, 0) = 0  AND ISNULL(IsPriorMember, 0) = 0 THEN 1 ELSE 0 END


-- SingleShowFullPricePerformancesCY --
SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, series.DimEventHeaderId, series.EventName SeriesName, perf.DimEventId, perf.EventName, perf.EventDate, SUM(f.QtySeat) TotalTickets
INTO #SingleShowPurchases
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
JOIN dbo.DimCustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
JOIN dbo.DimEventHeader_V2 series (NOLOCK)
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
WHERE f.DimTicketClassId IN (77, 78, 79, 80)
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID, series.DimEventHeaderId, series.EventName, perf.DimEventId, perf.EventName, perf.EventDate

UPDATE a
SET a.SingleShowFullPricePerformancesCY = ISNULL(b.CountPerformances, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT DimEventId) CountPerformances
	FROM #SingleShowPurchases
	WHERE EventDate > = (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID



-- SingleShowFullPriceSeriesCY --
UPDATE a
SET a.SingleShowFullPriceSeriesCY = ISNULL(b.CountSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT DimEventHeaderId) CountSeries
	FROM #SingleShowPurchases
	WHERE EventDate > = (GETDATE() - 365)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- SingleShowFullPricePerformancesPY --
UPDATE a
SET a.SingleShowFullPricePerformancesPY = ISNULL(b.CountPerformances, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT DimEventId) CountPerformances
	FROM #SingleShowPurchases
	WHERE EventDate < (GETDATE() - 365) AND EventDate >= (GETDATE() - 730)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- SingleShowFullPriceSeriesPY --
UPDATE a
SET a.SingleShowFullPriceSeriesPY = ISNULL(b.CountSeries, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT DimEventHeaderId) CountSeries
	FROM #SingleShowPurchases
	WHERE EventDate < (GETDATE() - 365) AND EventDate >= (GETDATE() - 730)
	GROUP BY SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- IsGroupTicketBuyer --
UPDATE a
SET a.IsGroupBuyer = ISNULL(b.IsGroupBuyer, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 AS IsGroupBuyer
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimTicketType_V2 tt (NOLOCK)
			ON f.DimTicketTypeId = tt.DimTicketTypeId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		WHERE tt.TicketTypeName = 'Group'
			AND perf.EventDate >= (GETDATE() - 365)
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- IsGroupCorpBuyer --
UPDATE a
SET a.IsGroupCorpBuyer = ISNULL(b.IsGroupCorpBuyer, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 AS IsGroupCorpBuyer
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimTicketClass_V2 tc (NOLOCK)
			ON f.DimTicketClassId = tc.DimTicketClassId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		WHERE tc.TicketClass = 'Group Corp'
			AND perf.EventDate >= (GETDATE() - 365)
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- TicketScanPercentage --
SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID
	, CONVERT(DECIMAL(18,2), COUNT(*)) TicketCount
	, CONVERT(DECIMAL(18,2), SUM(CASE WHEN t.ticket_taken_date IS NOT NULL THEN 1 ELSE 0 END)) TicketScanCount
INTO #TicketScans
FROM ods.AV_ts_ticket t (NOLOCK)
JOIN ods.AV_ts_order o (NOLOCK)
	ON t.ticket_order_id = o.order_id
JOIN ods.AV_ts_customer cust (NOLOCK)
	ON o.order_customer_id = cust.customer_id
JOIN dbo.DimCustomer dc (NOLOCK)
	ON cust.customer_default_contact_id = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID

UPDATE a
SET a.TicketScanPercentage = b.TicketScanPcnt
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT SSB_CRMSYSTEM_CONTACT_ID, CAST((CASE WHEN TicketCount <> 0 THEN TicketScanCount/TicketCount*100 ELSE NULL END) AS DECIMAL(10,2)) TicketScanPcnt
		FROM #TicketScans
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID



-- Refunds (Total number or value) --



-- IsADABuyer --
UPDATE a
SET a.IsADABuyer = ISNULL(b.IsADABuyer, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 AS IsADABuyer
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimTicketClass_V2 tc (NOLOCK)
			ON f.DimTicketClassId = tc.DimTicketClassId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		WHERE tc.TicketClass LIKE '%ADA%'
			AND perf.EventDate >= (GETDATE() - 365)
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- AccountClassificationID --
UPDATE a
SET a.AccountClassificationID = b.customer_class
FROM dbo.Contact_CustomFields a
JOIN ods.AV_ts_customer b
	ON a.PrimaryCustomerNumber = b.customer_number


-- LegacyAccountNumber --
UPDATE a
SET a.LegacyAccountNumber = b.customer_reference_code
FROM dbo.Contact_CustomFields a
JOIN ods.AV_ts_customer b
	ON a.PrimaryCustomerNumber = b.customer_number



-- CustomerUsername --
UPDATE a
SET a.CustomerUsername = ISNULL(b.UserName,'')	
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, u.[user_name] AS UserName
			, RANK() OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID ORDER BY dc.SourceSystem, dc.CreatedDate, dc.UpdatedDate, dc.NameIsCleanStatus DESC, dc.DimCustomerId) xRank
		FROM bkp.AV_ts_user u (NOLOCK)
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON u.user_contact_id = dc.SSID
			AND dc.SourceSystem = 'AV'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID AND b.xRank = 1


-- AccountLinkage --


-- MostRecentPromoCode --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, MAX(perf.EventDate) MostRecentEventDate
INTO #RecentPromoUse
FROM dbo.FactTicketSales_V2 f (NOLOCK)
JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
	ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
JOIN dbo.DimCustomer dc (NOLOCK)
	ON dtc.CustomerId = dc.SSID
	AND dc.SourceSystem = 'AV'
	AND dc.CustomerStatus = 'Primary'
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON f.DimEventId = perf.DimEventId
WHERE perf.EventDate >= (GETDATE() - 365) AND f.DimPromoId <> -1
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID

UPDATE a
SET a.MostRecentPromoCode = ISNULL(b.PromoCode, '')
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, promo.PromoCode
			, RANK() OVER(PARTITION BY r.SSB_CRMSYSTEM_CONTACT_ID ORDER BY promo.DimPromoId) xRank
		FROM dbo.FactTicketSales_V2 f (NOLOCK)
		JOIN dbo.DimPromo_V2 promo (NOLOCK)
			ON f.DimPromoId = promo.DimPromoId
		JOIN dbo.DimEvent_V2 perf (NOLOCK)
			ON f.DimEventId = perf.DimEventId
		JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
			ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON dtc.CustomerId = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN #RecentPromoUse r
			ON r.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
			AND r.MostRecentEventDate = perf.EventDate
		WHERE tc.TicketClass LIKE '%ADA%'
			AND perf.EventDate >= (GETDATE() - 365)
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
		AND xRank = 1

-- IsGiftCardBuyer --
UPDATE a
SET a.IsGiftCardBuyer = ISNULL(b.IsGiftCardBuyer, 0)
FROM dbo.Contact_CustomFields a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, 1 AS IsGiftCardBuyer
		FROM bkp.AV_ts_gift_certificate gc (NOLOCK)
		JOIN ods.AV_ts_order o (NOLOCK)
			ON gc.gift_certificate_order_id = o.order_id
		JOIN ods.AV_ts_customer cust (NOLOCK)
			ON o.order_customer_id = cust.customer_id
		JOIN dbo.DimCustomer dc (NOLOCK)
			ON cust.customer_default_contact_id = dc.SSID
			AND dc.SourceSystem = 'AV'
			AND dc.CustomerStatus = 'Primary'
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID



-- CustomerCreateDate --
UPDATE a
SET a.MinCustomerCreateDate = b.MinCreatedDate
FROM dbo.Contact_CustomFields a
JOIN (
		SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, MIN(dc.CreatedDate) MinCreatedDate
		FROM dbo.dimcustomer dc (NOLOCK)
		JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID










GO
