SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ods].[AV_vw_Avail]
AS

WITH AdmissionAudit
AS (
		SELECT admission_audit_id, MIN([timestamp]) [Timestamp]
		FROM ods.AV_ts_admission_audit
		GROUP BY admission_audit_id
	)

SELECT adin.admissioninventory_admission_id AS ETL__SSID
	, adin.admissioninventory_admission_id AS ETL__SSID_AV_admission_id
	, ISNULL(DimDateID, -1) AS DimDateID
	, ISNULL(DimTimeID, -1) AS DimTimeID
	, ISNULL(venue.DimArenaId, -1) AS DimArenaID
	, ISNULL(season.DimSeasonId, -1) AS DimSeasonID
	, -1 AS DimItemID
	, ISNULL(perf.DimEventId, -1) AS DimEventID
	, -1 AS DimPlanID
	, ISNULL(pricezone.DimPriceLevelId, -1) AS DimPriceLevelID
	, -1 AS DimPriceTypeID
	, -1 AS DimPriceCodeID
	, ISNULL(seat.DimSeatId, -1) AS DimSeatID
	, -1 AS DimSeatStatusID
	, -1 AS DimPlanTypeID
	, -1 AS DimTicketTypeID
	, -1 AS DimSeatTypeID
	, -1 AS DimTicketClassID
	, aac.[Timestamp] AS PostedDateTime
	, 1 AS QtySeat
	, CAST(0 AS DECIMAL(18,6)) AS SubTotal
	, CAST(0 AS DECIMAL(18,6)) AS Fees
	, CAST(0 AS DECIMAL(18,6)) AS Taxes
	, CAST(0 AS DECIMAL(18,6)) AS Total
	, aac.Timestamp CreatedDate
	, aau.Timestamp UpdateDate
--SELECT COUNT(*)
FROM ods.AV_ts_admission_inventory adin (NOLOCK)
JOIN ods.AV_ts_admission ad (NOLOCK)
	ON adin.admissioninventory_admission_id = ad.admission_id
LEFT JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON ad.admission_performance_id = perf.ETL__SSID_AV_performance_id
LEFT JOIN dbo.DimSeat_V2 seat (NOLOCK)
	ON ad.admission_seat_id = seat.ETL__SSID_AV_seat_id
LEFT JOIN AdmissionAudit aac (NOLOCK)
	ON ad.admission_create_audit_id = aac.admission_audit_id
LEFT JOIN AdmissionAudit aau (NOLOCK)
	ON ad.admission_audit_id = aau.admission_audit_id
LEFT JOIN dbo.DimDate dd (NOLOCK)
	ON CAST(aac.[Timestamp] AS DATE) = dd.CalDate
LEFT JOIN dbo.DimTime dt (NOLOCK)
	ON CAST(aac.[Timestamp] AS TIME) = dt.Time24
LEFT JOIN dbo.DimEventHeader_V2 series (NOLOCK)
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
LEFT JOIN dbo.DimArena_V2 venue (NOLOCK)
	ON seat = venue.ETL__SSID_AV_venue_id
LEFT JOIN dbo.DimSeason_V2 season (NOLOCK)
	ON series.AV_series_group = season.SeasonName
LEFT JOIN ods.AV_ts_seat_template_seat sts (NOLOCK)
	ON sts.seattempseat_template_id = ad.admission_price_template_id
	AND ad.admission_seat_id = sts.seattempseat_seat_id
LEFT JOIN dbo.DimPriceLevel_V2 pricezone (NOLOCK)
	ON pricezone.ETL__SSID_AV_value_legend_id = CASE WHEN ad.admission_price_value_id IS NOT NULL THEN ad.admission_price_value_id
													ELSE sts.seattempseat_template_value_id END







--5146208














GO
