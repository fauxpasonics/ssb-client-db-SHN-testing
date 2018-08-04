SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ods].[AV_vw_Ticket]
AS

WITH OrderAdmissionAudit
AS (
	SELECT orderadmission_audit_id, MIN([timestamp]) [Timestamp]
	FROM ods.AV_ts_order_admission_audit
	GROUP BY orderadmission_audit_id
)
SELECT ordad.orderadmission_id AS ETL__SSID
	, ordad.orderadmission_admission_id AS ETL__SSID_admission_id
	, perf.ETL__SSID_AV_performance_id
	, seat.ETL__SSID_AV_section_id
	, seat.ETL__SSID_AV_seat_id
	, seat.AV_sys_section AS ETL__SSID_AV_sys_section
	, seat.AV_sys_row AS ETL__SSID_AV_sys_row
	, seat.AV_sys_seat AS ETL__SSID_AV_sys_seat
	, bundle.ETL__SSID_AV_bundle_id
	, cust.ETL__SSID_AV_customer_id
	, pricetype.ETL__SSID_AV_price_type_id
	, pricezone.ETL__SSID_AV_value_legend_id
	, promo.ETL__SSID_AV_promo_code_id
	, season.ETL__SSID_AV_season
	, series.ETL__SSID_AV_series_id
	, venue.ETL__SSID_AV_venue_id
	, ord.order_id AS ETL__SSID_AV_order_id
	, ad.admission_id AS ETL__SSID_AV_admission_id
	, ISNULL(dd.DimDateId, -1) AS DimDateID
	, ISNULL(dt.DimTimeId, -1) AS DimTimeID
	, ISNULL(cust.DimTicketCustomerId, -1) AS DimTicketCustomerID
	, ISNULL(venue.DimArenaId, -1) AS DimArenaID
	, ISNULL(season.DimSeasonID, -1) AS DimSeasonID
	, -1 AS DimItemID
	, ISNULL(perf.DimEventId, -1) AS DimEventID
	, ISNULL(bundle.DimPlanId, -1) AS DimPlanID
	, ISNULL(pricezone.DimPriceLevelId, -1) AS DimPriceLevelID
	, ISNULL(pricetype.DimPriceTypeId, -1) AS DimPriceTypeID
	, -1 AS DimPriceCodeID
	, -1 AS DimLedgerID
	, ISNULL(seat.DimSeatId, -1) AS DimSeatID
	, -1 AS DimSeatStatusID
	, -1 AS DimRepID
	, -1 AS DimSalesCodeID
	, ISNULL(promo.DimPromoId, -1) DimPromoID
	, -1 AS DimEventZoneID
	, -1 AS DimOfferID
	, -1 AS DimPlanTypeID
	, -1 AS DimTicketTypeID
	, -1 AS DimSeatTypeID
	, -1 AS DimTicketClassID
	, ord.order_active_date AS OrderDate
	, 1 AS QtySeat
	, NULL AS QtySeatFSE
	, NULL AS QtySeatRenewable
	, CAST(ordad.orderadmission_net/100 AS DECIMAL(18,6)) AS RevenueTicket
	, CAST(ordad.orderadmission_add_charge1/100 AS DECIMAL(18,6)) AS RevenueFees
	, CAST(ordad.orderadmission_incl_charge2/100 AS DECIMAL(18,6)) AS RevenueSurcharge
	, CAST(ISNULL(NULL,0) AS DECIMAL(18,6)) AS RevenueTax
	, CAST(ordad.orderadmission_total/100 AS DECIMAL(18,6)) AS RevenueTotal
	, CAST(ordad.orderadmission_amount/100 AS DECIMAL(18,6)) AS FullPrice
	, CAST(ISNULL(NULL,0) AS DECIMAL(18,6)) AS Discount
	, CASE WHEN (ordad.orderadmission_total - (ordad.orderadmission_add_charge1_paid + ordad.orderadmission_incl_charge2_paid + ordad.orderadmission_net_paid)) > 0 THEN 'Y' ELSE 'N' END AS PaidStatus
	, CAST((ordad.orderadmission_add_charge1_paid + ordad.orderadmission_incl_charge2_paid + ordad.orderadmission_net_paid)/100 AS DECIMAL(18,6)) AS PaidAmount
	, CAST((ordad.orderadmission_total - (ordad.orderadmission_add_charge1_paid + ordad.orderadmission_incl_charge2_paid + ordad.orderadmission_net_paid))/100 AS DECIMAL(18,6)) AS OwedAmount
	, CAST(NULL AS DATETIME) AS PaymentDateFirst
	, CAST(NULL AS DATETIME) AS PaymentDateLast
	, 0 AS IsSold
	, 0 AS IsReserved
	, 0 AS IsReturned
	, 0 AS IsPremium
	, 0 AS IsDiscount
	, 0 AS IsComp
	, 0 AS IsHost
	, 0 AS IsPlan
	, 0 AS IsPartial
	, 0 AS IsSingleEvent
	, 0 AS IsGroup
	, 0 AS IsBroker
	, 0 AS IsRenewal
	, 0 AS IsExpanded
	, 0 AS IsAutoRenewalNextSeason
	, ord.order_number AS AV_order_num
	, ad.admission_ticket_number AV_ticket_number
	, ad.admission_ticket_barcode AV_ticket_barcode
	, oaac.[timestamp] AS CreateDate
	, ISNULL(oaau.[timestamp], oaac.[timestamp]) AS UpdateDate
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
FROM ods.AV_ts_order_admission ordad (NOLOCK)
JOIN dbo.DimPriceType_V2 pricetype (NOLOCK)
	ON ordad.orderadmission_price_type_id = pricetype.ETL__SSID_AV_price_type_id
JOIN dbo.DimSeat_V2 seat (NOLOCK)
	ON ordad.orderadmission_seat_id = seat.ETL__SSID_AV_seat_id
JOIN dbo.DimEvent_V2 perf (NOLOCK)
	ON ordad.orderadmission_performance_id = perf.ETL__SSID_AV_performance_id
LEFT JOIN ods.AV_ts_order ord (NOLOCK)
	ON ordad.orderadmission_order_id = ord.order_id
JOIN ods.AV_ts_admission ad (NOLOCK)
	ON ordad.orderadmission_admission_id = ad.admission_id
LEFT JOIN dbo.DimTicketCustomer_V2 cust (NOLOCK)
	ON ord.order_customer_id = cust.ETL__SSID
JOIN dbo.DimEventHeader_V2 series (NOLOCK)
	ON perf.AV_series_id = series.ETL__SSID_AV_series_id
JOIN dbo.DimSeason_V2 season (NOLOCK)
	ON series.AV_series_group = season.ETL__SSID
JOIN dbo.DimArena_V2 venue (NOLOCK)
	ON series.AV_venue_id = venue.ETL__SSID_AV_venue_id
LEFT JOIN dbo.DimDate dd (NOLOCK)
	ON CAST(ord.order_active_date AS DATE) = dd.CalDate
LEFT JOIN dbo.DimTime dt (NOLOCK)
	ON CAST(ord.order_active_date AS TIME) = dt.Time24
LEFT JOIN ods.AV_ts_seat_template_seat sts (NOLOCK)
	ON sts.seattempseat_seat_template_id = ad.admission_price_template_id
LEFT JOIN dbo.DimPriceLevel_V2 pricezone (NOLOCK)
	ON pricezone.ETL__SSID_AV_value_legend_id = CASE WHEN ad.admission_price_value_id IS NOT NULL THEN ad.admission_price_value_id
													ELSE sts.seattempseat_template_value_id END
LEFT JOIN dbo.DimPromo_V2 promo (NOLOCK)
	ON ordad.orderadmission_promo_code_id = promo.ETL__SSID_AV_promo_code_id
LEFT JOIN ods.AV_ts_order_bundle ordbun (NOLOCK)
	ON ordad.orderadmission_order_bundle_id = ordbun.orderbundle_id
LEFT JOIN ods.AV_ts_bundleversion bunver (NOLOCK)
	ON ordbun.orderbundle_bundle_version_id = bunver.bundleversion_version_id
LEFT JOIN dbo.DimPlan_V2 bundle (NOLOCK)
	ON bunver.bundleversion_bundle_id = bundle.ETL__SSID_AV_bundle_id
LEFT JOIN OrderAdmissionAudit oaac (NOLOCK)
	ON ordad.orderadmission_create_audit_id = oaac.orderadmission_audit_id
LEFT JOIN OrderAdmissionAudit oaau (NOLOCK)
	ON ordad.orderadmission_audit_id = oaau.orderadmission_audit_id







GO
