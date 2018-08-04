SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[DimCustomer_MasterLoad]

AS
BEGIN


-- Hello World
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'SHN', @LoadView = '[etl].[vw_Load_DimCustomer_HelloWorld]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'


-- Vertical Response
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'SHN', @LoadView = '[etl].[vw_Load_DimCustomer_VerticalResponse]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'


-- Audience View
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'SHN', @LoadView = 'etl.vw_Load_DimCustomer_AudienceView', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'


-- Data Uploader
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'SHN', @LoadView = 'api.UploadDimCustomerStaging', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '1'



END


GO
