SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ods].[AV_vw_Inventory]
AS
SELECT ISNULL(perf.DimArenaId, -1) DimArenaID
	, ISNULL(season.DimSeasonId, -1) DimSeasonID
	, ISNULL(perf.DimEventId, -1) DimEventID
	, ISNULL(seat.DimSeatId, -1) DimSeatID
	, -1 AS DimSeatStatusID
	, NULL AS SeatValue
	, ISNULL(fts.FactTicketSalesId,-1) FactTicketSalesID
	, -1 FactAttendanceID
	, -1 FactTicketActivityID_Resold
	, -1 FactTicketActivityID_Transferred
	, adin.admissioninventory_admission_id ETL__SSID
	, -1 FactAvailSeatsID
	, -1 FactHeldSeatsID
--SELECT COUNT(*)
FROM ods.AV_ts_admission_inventory adin (NOLOCK)
LEFT JOIN ods.AV_ts_admission ad (NOLOCK)
	ON adin.admissioninventory_admission_id = ad.admission_id
LEFT JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON adin.admissioninventory_performance_id = perf.ETL__SSID_AV_performance_id
LEFT JOIN dbo.DimEventHeader_V2 series (NOLOCK)
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
LEFT JOIN dbo.DimArena_V2 venue (NOLOCK)
	ON series.AV_venue_id = venue.ETL__SSID_AV_venue_id
LEFT JOIN dbo.DimSeason_V2 season (NOLOCK)
	ON series.AV_series_group = season.SeasonName
LEFT JOIN dbo.DimSeat_V2 seat (NOLOCK)
	ON ad.admission_seat_id = seat.ETL__SSID_AV_seat_id
--LEFT JOIN ods.AV_ts_seat_template_seat sts (NOLOCK)
--	ON ad.admission_seat_id = sts.seattempseat_seat_id
--LEFT JOIN ods.AV_ts_value_legend pricezone (NOLOCK)
--	ON pricezone.value_legend_id = CASE WHEN ad.admission_price_value_id IS NOT NULL THEN ad.admission_price_value_id
--										ELSE sts.seattempseat_template_value_id END
LEFT JOIN dbo.FactTicketSales_V2 fts
	ON ad.admission_id = fts.ETL__SSID_AV_admission_id

;






GO
