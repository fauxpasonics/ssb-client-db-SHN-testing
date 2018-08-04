SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [etl].[vw_Load_AV_FactTicketSales] AS (

SELECT ETL__SSID, t.ETL__SSID_AV_admission_id, ETL__SSID_AV_performance_id, ETL__SSID_AV_section_id, t.ETL__SSID_AV_seat_id, t.ETL__SSID_AV_sys_section
	, t.ETL__SSID_AV_sys_row, t.ETL__SSID_AV_sys_seat, t.ETL__SSID_AV_bundle_id, t.ETL__SSID_AV_customer_id, t.ETL__SSID_AV_price_type_id, t.ETL__SSID_AV_value_legend_id
	, t.ETL__SSID_AV_promo_code_id, t.ETL__SSID_AV_season, t.ETL__SSID_AV_series_id, t.ETL__SSID_AV_venue_id, t.ETL__SSID_AV_order_id, t.DimDateID
	, t.DimTimeID, t.DimTicketCustomerId, t.DimArenaId, t.DimSeasonID, t.DimItemID, t.DimEventId, t.DimPlanID, t.DimPriceLevelId, t.DimPriceTypeId, t.DimPriceCodeID, t.DimLedgerID
	, t.DimSeatId AS DimSeatID_Start, t.DimSeatStatusID, t.DimRepID, t.DimSalesCodeID, t.DimPromoID, t.DimEventZoneID, t.DimOfferID, t.DimPlanTypeID, t.DimTicketTypeID, t.DimSeatTypeID
	, t.DimTicketClassID, t.OrderDate, CreatedBy, UpdatedBy, t.CreateDate, t.UpdateDate, t.QtySeat, t.QtySeatFSE, t.QtySeatRenewable, t.RevenueTicket, t.RevenueFees, t.RevenueSurcharge
	, t.RevenueTax, t.RevenueTotal, t.FullPrice, t.Discount, t.PaidStatus, t.PaidAmount, t.OwedAmount, t.PaymentDateFirst, t.PaymentDateLast, t.IsSold, t.IsReserved, t.IsReturned, t.IsPremium
	, t.IsDiscount, t.IsComp, t.IsHost, t.IsPlan, t.IsPartial, t.IsSingleEvent, t.IsGroup, t.IsBroker, t.IsRenewal, t.IsExpanded, t.IsAutoRenewalNextSeason, t.AV_order_num, t.AV_ticket_number
	, t.AV_ticket_barcode, t.Custom_Int_1, t.Custom_Int_2, t.Custom_Int_3, t.Custom_Int_4, t.Custom_Int_5, t.Custom_Dec_1, t.Custom_Dec_2, t.Custom_Dec_3, t.Custom_Dec_4, t.Custom_Dec_5
	, t.Custom_DateTime_1, t.Custom_DateTime_2, t.Custom_DateTime_3, t.Custom_DateTime_4, t.Custom_DateTime_5, t.Custom_Bit_1, t.Custom_Bit_2, t.Custom_Bit_3, t.Custom_Bit_4, t.Custom_Bit_5
	, t.Custom_nVarChar_1, t.Custom_nVarChar_2, t.Custom_nVarChar_3, t.Custom_nVarChar_4, t.Custom_nVarChar_5
FROM stg.AV_FactTicketSales t

)



GO
