SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[AV_LoadFactInventory_Sales]
(
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN

	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()	
	, fi.FactTicketSalesId = NULL
	, fi.DimSeatStatusId = 0
	FROM etl.vw_FactInventory fi
	LEFT OUTER JOIN etl.vw_FactTicketSales (NOLOCK) fts ON fi.FactTicketSalesId = fts.FactTicketSalesId
	WHERE fi.FactTicketSalesId IS NOT NULL
	AND fts.FactTicketSalesId IS NULL
	/*
	DECLARE @SoldDimSeatStatusId INT 

	SELECT @SoldDimSeatStatusId = DimSeatStatusId
	FROM etl.vw_DimSeatStatus
	WHERE ETL__SSID = 'CI Default: SOLD'
	*/

	SELECT f.DimEventId, dSeat.DimSeatId, f.FactTicketSalesId, -1 DimSeatStatusID--@SoldDimSeatStatusId DimSeatStatusid
	INTO #FactTicketSales

	FROM etl.vw_FactTicketSales (NOLOCK) f
	INNER JOIN etl.vw_DimEvent (NOLOCK) dEvent on f.DimEventId = dEvent.DimEventId
	INNER JOIN etl.vw_DimSeat (NOLOCK) dSeat 
		ON f.ETL__SourceSystem = dSeat.ETL__SourceSystem
		AND f.ETL__SSID_AV_section_id = dSeat.ETL__SSID_AV_section_id
		AND dSeat.ETL__SSID_AV_seat_id = f.ETL__SSID_AV_seat_id

	WHERE dEvent.Config_IsFactInventoryEligible = 1

	CREATE NONCLUSTERED INDEX [IDX_BusinessKey] ON #FactTicketSales (DimEventId, DimSeatId)


	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()
	, fi.DimSeatStatusid = s.DimSeatStatusid
	, fi.FactTicketSalesId = s.FactTicketSalesId
	FROM etl.vw_FactInventory fi
	INNER JOIN #FactTicketSales s ON fi.DimEventId = s.DimEventId AND fi.DimSeatId = s.DimSeatId
	WHERE ISNULL(fi.DimSeatStatusId, -987) = ISNULL(s.DimSeatStatusId, -987) OR ISNULL(fi.FactTicketSalesId, -987) <> ISNULL(s.FactTicketSalesId, -987)

	DROP TABLE #FactTicketSales

END


GO
