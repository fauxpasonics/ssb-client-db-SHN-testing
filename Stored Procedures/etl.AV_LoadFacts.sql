SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[AV_LoadFacts]
(
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = NULL
)

AS
BEGIN

	SELECT 'Start...', GETDATE() ts

	SELECT 'Step 2...', GETDATE() ts
	
	EXEC etl.AV_Stage_FactTicketSales @BatchId = @BatchId, @Options = @Options

	SELECT 'Step 3...', GETDATE() ts

	EXEC etl.Cust_FactTicketSalesProcessing @BatchId = @BatchId, @Options = @Options

	SELECT 'Step 4...', GETDATE() ts	

	EXEC [etl].[SSB_StandardModelLoad] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactTicketSales', @Source = 'etl.vw_Load_AV_FactTicketSales'
	, @BusinessKey = 'ETL__SSID_AV_admission_id', @SourceSystem = 'AV', @Options = @Options

	SELECT 'Step 5...', GETDATE() ts	
	/*
	EXEC [etl].[TM_Stage_FactTicketActivity] @BatchId = @BatchId, @Options = @Options

	EXEC [etl].[SSB_StandardModelLoad] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactTicketActivity', @Source = 'etl.vw_Load_TM_FactTicketActivity', @BusinessKey = 'ETL__SSID_TM_ods_id', @SourceSystem = 'TM'

	EXEC [etl].[TM_Stage_FactHeldSeats] 

	DELETE t
	FROM etl.vw_FactHeldSeats t
	LEFT OUTER JOIN ods.TM_HeldSeats s ON t.ETL__SSID_TM_ods_id = s.id
	WHERE s.id IS NULL

	EXEC [etl].[SSB_StandardModelLoad] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactHeldSeats', @Source = 'etl.vw_Load_TM_FactHeldSeats'
	, @BusinessKey = 'ETL__SSID_TM_ods_id', @SourceSystem = 'TM'

	*/


	EXEC [etl].[AV_Stage_FactAvailSeats] 

	DELETE t
	FROM etl.vw_FactAvailSeats t
	LEFT OUTER JOIN ods.AV_vw_Avail s ON t.ETL__SSID_AV_admission_id = s.ETL__SSID_AV_admission_id
	WHERE s.ETL__SSID_AV_admission_id IS NULL

	EXEC [etl].[SSB_StandardModelLoad] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactAvailSeats', @Source = 'etl.vw_Load_AV_FactAvailSeats'
	, @BusinessKey = 'ETL__SSID', @SourceSystem = 'AV'


	--EXEC etl.TM_LoadFactInventory_Seats

	SELECT 'Step 6...', GETDATE() ts

	--EXEC etl.AV_LoadFactInventory_Held --@BatchId = @BatchId, @Options = @Options

	EXEC etl.AV_LoadFactInventory_Avail	--@BatchId = @BatchId, @Options = @Options

	EXEC etl.AV_LoadFactInventory_Sales

	SELECT 'Step 7...', GETDATE() ts

	--EXEC etl.TM_LoadFactInventory_Resold --@BatchId = @BatchId, @Options = @Options

	

	--EXEC etl.TM_LoadFactInventory_Tranferred --@BatchId = @BatchId, @Options = @Options

	SELECT 'Step 8...', GETDATE() ts

	

	SELECT 'Step 9...', GETDATE() ts



	EXEC etl.AV_LoadFactAttendance @BatchId = @BatchId, @Options = @Options

	SELECT 'Step 10...', GETDATE() ts
	

END













GO
