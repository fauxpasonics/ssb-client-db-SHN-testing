SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ods].[AV_vw_Attendance]
AS

SELECT ticket.ticket_number ETL__SSID
	, perf.ETL__SSID_AV_performance_id
	, seat.ETL__SSID_AV_section_id
	, seat.ETL__SSID_AV_seat_id
	, ord.order_customer_id AS ETL__SSID_AV_customer_id
	, ISNULL(venue.DimArenaId, -1) AS DimArenaID
	, ISNULL(perf.DimEventId, -1) AS DimEventID
	, ISNULL(season.DimSeasonId, -1) AS DimSeasonID
	, ISNULL(seat.DimSeatId, -1) AS DimSeatID
	, ISNULL(dd.DimDateId, -1) AS DimDateID
	, ISNULL(dt.DimTimeId, -1) AS DimTimeID
	, ISNULL(cust.DimTicketCustomerId, -1) DimTicketCustomerID
	, -1 DimTicketCustomer_Attended
	, -1 DimScanGateID
	, -1 DimScanTypeID
	, 1 ScanCount
	, 0 ScanCountFailed
	, ticket.ticket_taken_date AS ScanDateTime
	, ticket.ticket_barcode AS Barcode
	, 0 AS IsMobile
	, CAST(NULL AS NVARCHAR(255)) AS CreatedBy
	, CAST(NULL AS NVARCHAR(255)) AS UpdatedBy
	, NULL AS CreatedDate
	, NULL AS UpdatedDate
	, CAST(NULL AS INT) AS Custom_Int_1
	, CAST(NULL AS INT) AS Custom_Int_2
	, CAST(NULL AS INT) AS Custom_Int_3
	, CAST(NULL AS INT) AS Custom_Int_4
	, CAST(NULL AS INT) AS Custom_Int_5
	, CAST(NULL AS DECIMAL(18,6)) AS Custom_Dec_1
	, CAST(NULL AS DECIMAL(18,6)) AS Custom_Dec_2
	, CAST(NULL AS DECIMAL(18,6)) AS Custom_Dec_3
	, CAST(NULL AS DECIMAL(18,6)) AS Custom_Dec_4
	, CAST(NULL AS DECIMAL(18,6)) AS Custom_Dec_5
	, CAST(NULL AS DATETIME) AS Custom_DateTime_1
	, CAST(NULL AS DATETIME) AS Custom_DateTime_2
	, CAST(NULL AS DATETIME) AS Custom_DateTime_3
	, CAST(NULL AS DATETIME) AS Custom_DateTime_4
	, CAST(NULL AS DATETIME) AS Custom_DateTime_5
	, CAST(NULL AS BIT) AS Custom_Bit_1
	, CAST(NULL AS BIT) AS Custom_Bit_2
	, CAST(NULL AS BIT) AS Custom_Bit_3
	, CAST(NULL AS BIT) AS Custom_Bit_4
	, CAST(NULL AS BIT) AS Custom_Bit_5
	, CAST(NULL AS NVARCHAR(255)) AS Custom_nVarChar_1
	, CAST(NULL AS NVARCHAR(255)) AS Custom_nVarChar_2
	, CAST(NULL AS NVARCHAR(255)) AS Custom_nVarChar_3
	, CAST(NULL AS NVARCHAR(255)) AS Custom_nVarChar_4
	, CAST(NULL AS NVARCHAR(255)) AS Custom_nVarChar_5
--SELECT COUNT(*)
FROM ods.AV_ts_ticket ticket
LEFT JOIN dbo.DimEvent_V2 perf
	ON ticket.ticket_performance_id = perf.ETL__SSID_AV_performance_id
LEFT JOIN ods.AV_ts_order ord
	ON ticket.ticket_order_id = ord.order_id
LEFT JOIN dbo.DimSeat_V2 seat
	ON ticket.ticket_seat_id = seat.ETL__SSID_AV_seat_id
LEFT JOIN dbo.DimEventHeader_V2 series
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
LEFT JOIN dbo.DimArena venue
	ON series.AV_venue_id = venue.ETL__SSID_AV_venue_id
LEFT JOIN dbo.DimSeason_V2 season
	ON series.AV_series_group = season.SeasonName
LEFT JOIN dbo.DimDate dd
	ON CAST(ticket.ticket_taken_date AS DATE) = dd.CalDate
LEFT JOIN dbo.DimTime dt
	ON CAST(ticket.ticket_taken_date AS TIME) = dt.Time24
LEFT JOIN dbo.DimTicketCustomer_V2 cust
	ON ord.order_customer_id = cust.ETL__SSID_AV_customer_id
WHERE ticket.ticket_record_state = 0
GO
