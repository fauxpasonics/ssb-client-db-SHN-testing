SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [etl].[AV_LoadFactAttendance]
(
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN

	DECLARE @OptionsXML XML = TRY_CAST(@Options AS XML)


	DECLARE @LoadDate DATETIME = (GETDATE() - 2)

	SELECT @LoadDate = t.x.value('LoadDate[1]','DateTime')
	FROM @OptionsXML.nodes('options') t(x)

	PRINT @LoadDate

SELECT *
INTO #AttendData
--SELECT COUNT(*)
FROM ods.AV_vw_Attendance
WHERE UpdatedDate > @LoadDate


CREATE NONCLUSTERED INDEX IX_seat ON #AttendData (DimEventID, DimSeatID)
CREATE NONCLUSTERED INDEX IX_customer_id ON #AttendData (ETL__SSID_AV_customer_id)


INSERT INTO etl.vw_FactAttendance (ETL__SSID, ETL__SSID_AV_performance_id, ETL__SSID_AV_section_id, ETL__SSID_AV_seat_id,
	ETL__SSID_AV_customer_id, DimArenaId, DimSeasonId, DimEventId, DimSeatId, DimDateId, DimTimeId, DimTicketCustomerId,
	DimTicketCustomerId_Attended, DimScanGateId, DimScanTypeId, ScanCount, ScanCountFailed, ScanDateTime, Barcode, IsMobile,
	CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, Custom_Int_1, Custom_Int_2, Custom_Int_3, Custom_Int_4, Custom_Int_5,
	Custom_Dec_1, Custom_Dec_2, Custom_Dec_3, Custom_Dec_4, Custom_Dec_5, Custom_DateTime_1, Custom_DateTime_2, Custom_DateTime_3,
	Custom_DateTime_4, Custom_DateTime_5, Custom_Bit_1, Custom_Bit_2, Custom_Bit_3, Custom_Bit_4, Custom_Bit_5, Custom_nVarChar_1,
	Custom_nVarChar_2, Custom_nVarChar_3, Custom_nVarChar_4, Custom_nVarChar_5)

    
SELECT a.ETL__SSID, a.ETL__SSID_AV_performance_id, a.ETL__SSID_AV_section_id, a.ETL__SSID_AV_seat_id
	, a.ETL__SSID_AV_customer_id, a.DimArenaID, a.DimSeasonID, a.DimEventID, a.DimSeatID, a.DimDateID, a.DimTimeID, a.DimTicketCustomerID
	, a.DimTicketCustomer_Attended, a.DimScanGateID, a.DimScanTypeID, a.ScanCount, a.ScanCountFailed, a.ScanDateTime, a.Barcode, a.IsMobile
	, a.CreatedBy, a.UpdatedBy, a.CreatedDate, a.UpdatedDate, a.Custom_Int_1, a.Custom_Int_2, a.Custom_Int_3, a.Custom_Int_4, a.Custom_Int_5
	, a.Custom_Dec_1, a.Custom_Dec_2, a.Custom_Dec_3, a.Custom_Dec_4, a.Custom_Dec_5, a.Custom_DateTime_1, a.Custom_DateTime_2, a.Custom_DateTime_3
	, a.Custom_DateTime_4, a.Custom_DateTime_5, a.Custom_Bit_1, a.Custom_Bit_2, a.Custom_Bit_3, a.Custom_Bit_4, a.Custom_Bit_5, a.Custom_nVarChar_1
	, a.Custom_nVarChar_2, a.Custom_nVarChar_3, a.Custom_nVarChar_4, a.Custom_nVarChar_5
--SELECT COUNT(*)
FROM #AttendData a
LEFT JOIN etl.vw_FactAttendance f ON f.DimEventId = a.DimEventID AND f.DimSeatId = a.DimSeatID AND f.ETL__SSID = a.ETL__SSID
WHERE f.FactAttendanceId IS NULL


UPDATE fi
SET fi.ETL__UpdatedDate = GETDATE()
, fi.FactAttendanceId = fa.FactAttendanceId
FROM etl.vw_FactInventory fi
JOIN etl.vw_FactAttendance fa
	ON fi.DimEventId = fa.DimEventId AND fi.DimSeatId = fa.DimSeatId AND fa.DimEventId <> -1
WHERE ISNULL(fi.FactAttendanceId, -987) <> ISNULL(fa.FactAttendanceId, -987)


END






GO
