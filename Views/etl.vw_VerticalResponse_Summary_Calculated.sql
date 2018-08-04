SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_VerticalResponse_Summary_Calculated]
AS
/*
WITH TicketSales
AS (
	SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID
		, CASE WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 61 AND 90 THEN 'Last 90 days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 91 AND 120 THEN 'Last 120 days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 121 AND 365 THEN 'Last 365 days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) > 365 THEN 'Older'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) IS NULL THEN 'No Deliveries'
			END AS Bucket
		, SUM(f.QtySeat)
	FROM dbo.FactTicketSales_V2 f (NOLOCK)
	JOIN dbo.DimTicketCustomer_V2 dtc (NOLOCK)
		ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
	JOIN dbo.DimCustomer dc (NOLOCK)
		ON dtc.ETL__SSID_AV_customer_id = dc.AccountId
		AND dc.SourceSystem = 'AV'
	JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
		ON dc.DimCustomerId = ssbid.DimCustomerId
	JOIN dbo.DimDate d (NOLOCK)
		ON d.DimDateId = f.DimDateId
	GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID
		, CASE WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 61 AND 90 THEN 'Last 90 days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 91 AND 120 THEN 'Last 120 days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) BETWEEN 121 AND 365 THEN 'Last 365 days'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) > 365 THEN 'Older'
			WHEN DATEDIFF(dd,d.CalDate,GETDATE()) IS NULL THEN 'No Deliveries'
			END
)
*/

WITH FirstStep
AS (
	SELECT a.*
		, (CAST(OpenCount AS DECIMAL)/CAST(DeliveryCount AS DECIMAL))*100 AS OpenPcnt
		, (CAST(ClickCount AS DECIMAL)/CAST(DeliveryCount AS DECIMAL))*100 AS ClickPcnt
		, (CAST(BounceCount AS DECIMAL)/CAST(DeliveryCount AS DECIMAL))*100 AS BouncePcnt
		, CASE WHEN DaysSinceLastDelivery BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DaysSinceLastDelivery BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DaysSinceLastDelivery BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DaysSinceLastDelivery BETWEEN 61 AND 90 THEN 'Last 90 Days'
			WHEN DaysSinceLastDelivery BETWEEN 91 AND 120 THEN 'Last 120 Days'
			WHEN DaysSinceLastDelivery BETWEEN 121 AND 365 THEN 'Last 365 Days'
			WHEN DaysSinceLastDelivery > 365 THEN 'Older'
			WHEN DaysSinceLastDelivery IS NULL THEN 'Zero Deliveries'
			END AS LastDeliveryBucket
		, CASE WHEN DaysSinceLastOpen BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DaysSinceLastOpen BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DaysSinceLastOpen BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DaysSinceLastOpen BETWEEN 61 AND 90 THEN 'Last 90 Days'
			WHEN DaysSinceLastOpen BETWEEN 91 AND 120 THEN 'Last 120 Days'
			WHEN DaysSinceLastOpen BETWEEN 121 AND 365 THEN 'Last 365 Days'
			WHEN DaysSinceLastOpen > 365 THEN 'Older'
			WHEN DaysSinceLastOpen IS NULL THEN 'Zero Opens'
			END AS LastOpenBucket
		, CASE WHEN DaysSinceLastClick BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DaysSinceLastClick BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DaysSinceLastClick BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DaysSinceLastClick BETWEEN 61 AND 90 THEN 'Last 90 Days'
			WHEN DaysSinceLastClick BETWEEN 91 AND 120 THEN 'Last 120 Days'
			WHEN DaysSinceLastClick BETWEEN 121 AND 365 THEN 'Last 365 Days'
			WHEN DaysSinceLastClick > 365 THEN 'Older'
			WHEN DaysSinceLastClick IS NULL THEN 'Zero Clicks'
			END AS LastClickBucket
		, CASE WHEN DaysSinceLastBounce BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DaysSinceLastBounce BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DaysSinceLastBounce BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DaysSinceLastBounce BETWEEN 61 AND 90 THEN 'Last 90 Days'
			WHEN DaysSinceLastBounce BETWEEN 91 AND 120 THEN 'Last 120 Days'
			WHEN DaysSinceLastBounce BETWEEN 121 AND 365 THEN 'Last 365 Days'
			WHEN DaysSinceLastBounce > 365 THEN 'Older'
			WHEN DaysSinceLastBounce IS NULL THEN 'Zero Bounces'
			END AS LastBounceBucket
		, CASE WHEN DaysSinceLastUnsub BETWEEN 0 AND 15 THEN 'Last 15 Days'
			WHEN DaysSinceLastUnsub BETWEEN 16 AND 30 THEN 'Last 30 Days'
			WHEN DaysSinceLastUnsub BETWEEN 31 AND 60 THEN 'Last 60 Days'
			WHEN DaysSinceLastUnsub BETWEEN 61 AND 90 THEN 'Last 90 Days'
			WHEN DaysSinceLastUnsub BETWEEN 91 AND 120 THEN 'Last 120 Days'
			WHEN DaysSinceLastUnsub BETWEEN 121 AND 365 THEN 'Last 365 Days'
			WHEN DaysSinceLastUnsub > 365 THEN 'Older'
			WHEN DaysSinceLastUnsub IS NULL THEN 'Zero Unsubs'
			END AS LastUnsubBucket
		, b.PrimaryCustomerNumber
		, b.IsCurrentMember
		, b.IsPriorMember
		, b.IsOlderMember
		, b.IsActive
		, b.IsHamiltonBuyer
		, b.CYSpend
		, b.PYSpend
		, b.LifetimeValue
		, b.CountCYSeries
		, b.CountPYSeries
		, b.CountTotalSeries
		, b.MostRecentSeries
		, b.CYTickets
		, b.PYTickets
		, b.TotalTickets
	FROM ods.VerticalResponse_Summary_Calculated a (NOLOCK)
	JOIN dbo.Contact_CustomFields b (NOLOCK)
		ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
)

SELECT x.SSB_CRMSYSTEM_CONTACT_ID
	, x.DeliveryCount, x.MinDeliveryDate, x.MaxDeliveryDate, x.DaysSinceLastDelivery
	, x.OpenCount, x.MinOpenDate, x.MaxOpenDate, x.DaysSinceLastOpen
	, x.ClickCount, x.MinClickDate, x.MaxClickDate, x.DaysSinceLastClick
	, x.BounceCount, x.MinBounceDate, x.MaxBounceDate, x.DaysSinceLastBounce
	, x.UnsubCount, x.MinUnsubDate, x.MaxUnsubDate, x.DaysSinceLastUnsub
	, x.OpenPcnt
	, CASE WHEN x.OpenPcnt BETWEEN 0 AND 9.9999 THEN '0 - 10'
		WHEN x.OpenPcnt BETWEEN 10 AND 19.999 THEN '10 - 20'
		WHEN x.OpenPcnt BETWEEN 20 AND 29.999 THEN '20 - 30'
		WHEN x.OpenPcnt BETWEEN 30 AND 39.999 THEN '30 - 40'
		WHEN x.OpenPcnt BETWEEN 40 AND 49.999 THEN '40 - 50'
		WHEN x.OpenPcnt BETWEEN 50 AND 59.999 THEN '50 - 60'
		WHEN x.OpenPcnt BETWEEN 60 AND 69.999 THEN '60 - 70'
		WHEN x.OpenPcnt BETWEEN 70 AND 79.999 THEN '70 - 80'
		WHEN x.OpenPcnt BETWEEN 80 AND 89.999 THEN '80 - 90'
		WHEN x.OpenPcnt >= 90 THEN '90 - 100'
		END AS OpenPcntBucket
	, x.ClickPcnt
	, CASE WHEN x.ClickPcnt BETWEEN 0 AND 9.9999 THEN '0 - 10'
		WHEN x.ClickPcnt BETWEEN 10 AND 19.999 THEN '10 - 20'
		WHEN x.ClickPcnt BETWEEN 20 AND 29.999 THEN '20 - 30'
		WHEN x.ClickPcnt BETWEEN 30 AND 39.999 THEN '30 - 40'
		WHEN x.ClickPcnt BETWEEN 40 AND 49.999 THEN '40 - 50'
		WHEN x.ClickPcnt BETWEEN 50 AND 59.999 THEN '50 - 60'
		WHEN x.ClickPcnt BETWEEN 60 AND 69.999 THEN '60 - 70'
		WHEN x.ClickPcnt BETWEEN 70 AND 79.999 THEN '70 - 80'
		WHEN x.ClickPcnt BETWEEN 80 AND 89.999 THEN '80 - 90'
		WHEN x.ClickPcnt >= 90 THEN '90 - 100'
		END AS ClickPcntBucket
	, x.BouncePcnt
	, CASE WHEN x.BouncePcnt BETWEEN 0 AND 9.9999 THEN '0 - 10'
		WHEN x.BouncePcnt BETWEEN 10 AND 19.999 THEN '10 - 20'
		WHEN x.BouncePcnt BETWEEN 20 AND 29.999 THEN '20 - 30'
		WHEN x.BouncePcnt BETWEEN 30 AND 39.999 THEN '30 - 40'
		WHEN x.BouncePcnt BETWEEN 40 AND 49.999 THEN '40 - 50'
		WHEN x.BouncePcnt BETWEEN 50 AND 59.999 THEN '50 - 60'
		WHEN x.BouncePcnt BETWEEN 60 AND 69.999 THEN '60 - 70'
		WHEN x.BouncePcnt BETWEEN 70 AND 79.999 THEN '70 - 80'
		WHEN x.BouncePcnt BETWEEN 80 AND 89.999 THEN '80 - 90'
		WHEN x.BouncePcnt >= 90 THEN '90 - 100'
		END AS BouncePcntBucket
	, x.LastDeliveryBucket
	, x.LastOpenBucket
	, x.LastClickBucket
	, x.LastBounceBucket
	, x.LastUnsubBucket
	, x.PrimaryCustomerNumber
	, x.IsCurrentMember
	, x.IsPriorMember
	, x.IsOlderMember
	, x.IsActive
	, x.IsHamiltonBuyer
	, x.CYSpend
	, x.PYSpend
	, x.LifetimeValue
	, x.CountCYSeries
	, x.CountPYSeries
	, x.CountTotalSeries
	, x.MostRecentSeries
	, x.CYTickets
	, x.PYTickets
	, x.TotalTickets
FROM FirstStep x



GO
