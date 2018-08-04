SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[AV_Stage_FactAvailSeats] 
( 
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000', 
	@Options NVARCHAR(max) = NULL 
) 
 
AS 
BEGIN 
 

DECLARE @OptionsXML XML = TRY_CAST(@Options AS XML)


DECLARE @LoadDate DATETIME = (GETDATE() - 2)

SELECT @LoadDate = t.x.value('LoadDate[1]','DateTime')
FROM @OptionsXML.nodes('options') t(x)

PRINT @LoadDate


SELECT *
INTO #DataSet
FROM ods.AV_vw_Avail
WHERE UpdateDate >= @LoadDate

CREATE NONCLUSTERED INDEX IDX_event_id ON #DataSet (DimEventID)
CREATE NONCLUSTERED INDEX IDX_seat_id ON #DataSet (DimSeatID)


INSERT INTO stg.AV_FactAvailSeats (ETL__SSID, ETL__SSID_AV_admission_id, DimDateId, DimTimeId, DimArenaId, DimSeasonId, DimItemId, DimEventId,
	DimPlanId, DimPriceLevelId, DimPriceTypeId, DimPriceCodeId, DimSeatId_Start, DimSeatStatusId,
	DimPlanTypeId, DimTicketTypeId, DimSeatTypeId, DimTicketClassId, PostedDateTime, QtySeat,
	SubTotal, Fees, Taxes, Total)

SELECT ETL__SSID, ETL__SSID_AV_admission_id, DimDateID, DimTimeID, DimArenaID, DimSeasonID, DimItemID, DimEventID
	, DimPlanID, DimPriceLevelID, DimPriceTypeID, DimPriceCodeID, DimSeatID, DimSeatStatusID
	, DimPlanTypeID, DimTicketTypeID, DimSeatTypeID, DimTicketClassID, PostedDateTime, QtySeat
	, SubTotal, Fees, Taxes, Total
FROM #DataSet


DROP TABLE #DataSet

END





GO
