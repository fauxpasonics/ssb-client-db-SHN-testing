SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_Load_AV_FactAvailSeats] AS (

	SELECT ETL__SSID, ETL__SSID_AV_admission_id, DimDateId, DimTimeId, DimArenaId
	, DimSeasonId, DimItemId, DimEventId, DimPlanId, DimPriceLevelId, DimPriceTypeId, DimPriceCodeId, DimSeatId_Start, DimSeatStatusId
	, DimPlanTypeId, DimTicketTypeId, DimSeatTypeId, DimTicketClassId, PostedDateTime, QtySeat, SubTotal, Fees, Taxes, Total
FROM stg.AV_FactAvailSeats


)



GO
