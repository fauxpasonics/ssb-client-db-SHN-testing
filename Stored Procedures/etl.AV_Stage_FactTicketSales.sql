SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[AV_Stage_FactTicketSales] 
( 
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000', 
	@Options NVARCHAR(MAX) = NULL 
) 
 
AS 
BEGIN 
 
--DECLARE @Options NVARCHAR(MAX) = '<options><LoadDate>1900-01-01</LoadDate></options>'

DECLARE @OptionsXML XML = TRY_CAST(@Options AS XML)


DECLARE @LoadDate DATETIME = (GETDATE() - 2)

SELECT @LoadDate = t.x.value('LoadDate[1]','DateTime')
FROM @OptionsXML.nodes('options') t(x)

PRINT @LoadDate

SELECT tkt.*
INTO #tkt
--SELECT COUNT(*)
FROM [ods].[AV_vw_Ticket] tkt
WHERE ISNULL(tkt.UpdateDate, '1900-01-01') >= @LoadDate
--4921082

CREATE NONCLUSTERED INDEX IDX_event_id ON #tkt (DimEventId)
CREATE NONCLUSTERED INDEX IDX_series ON #tkt (ETL__SSID_AV_series_id)
CREATE NONCLUSTERED INDEX IDX_customer_id ON #tkt (ETL__SSID_AV_customer_id)
CREATE NONCLUSTERED INDEX IDX_price_type_id ON #tkt (DimPriceTypeId)
CREATE NONCLUSTERED INDEX IDX_promo_code_id ON #tkt (DimPromoID)
CREATE NONCLUSTERED INDEX IDX_plan_id ON #tkt (DimPlanID)
CREATE NONCLUSTERED INDEX IDX_price_level_id ON #tkt (DimPriceLevelId)
CREATE NONCLUSTERED INDEX IDX_seat_id ON #tkt (DimSeatID)


TRUNCATE TABLE stg.AV_FactTicketSales

INSERT INTO stg.AV_FactTicketSales (ETL__SSID, ETL__SSID_AV_admission_id, ETL__SSID_AV_performance_id, ETL__SSID_AV_section_id, ETL__SSID_AV_seat_id, ETL__SSID_AV_sys_section,
	ETL__SSID_AV_sys_row, ETL__SSID_AV_sys_seat, ETL__SSID_AV_bundle_id, ETL__SSID_AV_customer_id, ETL__SSID_AV_price_type_id, ETL__SSID_AV_value_legend_id,
	ETL__SSID_AV_promo_code_id, ETL__SSID_AV_season, ETL__SSID_AV_series_id, ETL__SSID_AV_venue_id, ETL__SSID_AV_order_id, DimDateId,
	DimTimeId, DimTicketCustomerId, DimArenaId, DimSeasonId, DimItemId, DimEventId, DimPlanId, DimPriceLevelId, DimPriceTypeId, DimPriceCodeId, DimLedgerId,
	DimSeatId, DimSeatStatusId, DimRepId, DimSalesCodeId, DimPromoId, DimEventZoneId, DimOfferId, DimPlanTypeId, DimTicketTypeId, DimSeatTypeId,
	DimTicketClassId, OrderDate, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, QtySeat, QtySeatFSE, QtySeatRenewable, RevenueTicket, RevenueFees, RevenueSurcharge,
	RevenueTax, RevenueTotal, FullPrice, Discount, PaidStatus, PaidAmount, OwedAmount, PaymentDateFirst, PaymentDateLast, IsSold, IsReserved, IsReturned, IsPremium,
	IsDiscount, IsComp, IsHost, IsPlan, IsPartial, IsSingleEvent, IsGroup, IsBroker, IsRenewal, IsExpanded, IsAutoRenewalNextSeason, AV_order_num, AV_ticket_number,
	AV_ticket_barcode, Custom_Int_1, Custom_Int_2, Custom_Int_3, Custom_Int_4, Custom_Int_5, Custom_Dec_1, Custom_Dec_2, Custom_Dec_3, Custom_Dec_4, Custom_Dec_5,
	Custom_DateTime_1, Custom_DateTime_2, Custom_DateTime_3, Custom_DateTime_4, Custom_DateTime_5, Custom_Bit_1, Custom_Bit_2, Custom_Bit_3, Custom_Bit_4, Custom_Bit_5,
	Custom_nVarChar_1, Custom_nVarChar_2, Custom_nVarChar_3, Custom_nVarChar_4, Custom_nVarChar_5)

SELECT ETL__SSID, ETL__SSID_AV_admission_id, ETL__SSID_AV_performance_id, ETL__SSID_AV_section_id, t.ETL__SSID_AV_seat_id, t.ETL__SSID_AV_sys_section
	, t.ETL__SSID_AV_sys_row, t.ETL__SSID_AV_sys_seat, t.ETL__SSID_AV_bundle_id, t.ETL__SSID_AV_customer_id, t.ETL__SSID_AV_price_type_id, t.ETL__SSID_AV_value_legend_id
	, t.ETL__SSID_AV_promo_code_id, t.ETL__SSID_AV_season, t.ETL__SSID_AV_series_id, t.ETL__SSID_AV_venue_id, t.ETL__SSID_AV_order_id, t.DimDateID
	, t.DimTimeID, t.DimTicketCustomerId, t.DimArenaId, t.DimSeasonID, t.DimItemID, t.DimEventId, t.DimPlanID, t.DimPriceLevelId, t.DimPriceTypeId, t.DimPriceCodeID, t.DimLedgerID
	, t.DimSeatId, t.DimSeatStatusID, t.DimRepID, t.DimSalesCodeID, t.DimPromoID, t.DimEventZoneID, t.DimOfferID, t.DimPlanTypeID, t.DimTicketTypeID, t.DimSeatTypeID
	, t.DimTicketClassID, t.OrderDate, NULL, NULL, t.CreateDate, t.UpdateDate, t.QtySeat, t.QtySeatFSE, t.QtySeatRenewable, t.RevenueTicket, t.RevenueFees, t.RevenueSurcharge
	, t.RevenueTax, t.RevenueTotal, t.FullPrice, t.Discount, t.PaidStatus, t.PaidAmount, t.OwedAmount, t.PaymentDateFirst, t.PaymentDateLast, t.IsSold, t.IsReserved, t.IsReturned, t.IsPremium
	, t.IsDiscount, t.IsComp, t.IsHost, t.IsPlan, t.IsPartial, t.IsSingleEvent, t.IsGroup, t.IsBroker, t.IsRenewal, t.IsExpanded, t.IsAutoRenewalNextSeason, t.AV_order_num, t.AV_ticket_number
	, t.AV_ticket_barcode, t.Custom_Int_1, t.Custom_Int_2, t.Custom_Int_3, t.Custom_Int_4, t.Custom_Int_5, t.Custom_Dec_1, t.Custom_Dec_2, t.Custom_Dec_3, t.Custom_Dec_4, t.Custom_Dec_5
	, t.Custom_DateTime_1, t.Custom_DateTime_2, t.Custom_DateTime_3, t.Custom_DateTime_4, t.Custom_DateTime_5, t.Custom_Bit_1, t.Custom_Bit_2, t.Custom_Bit_3, t.Custom_Bit_4, t.Custom_Bit_5
	, t.Custom_nVarChar_1, t.Custom_nVarChar_2, t.Custom_nVarChar_3, t.Custom_nVarChar_4, t.Custom_nVarChar_5
FROM #tkt t

DROP TABLE #tkt

END


GO
