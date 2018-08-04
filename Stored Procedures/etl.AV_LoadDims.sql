SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[AV_LoadDims]
(
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN


	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimArena', 'etl.vw_Load_AV_DimArena', 'ETL__SSID_AV_venue_id', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimEvent', 'etl.vw_Load_AV_DimEvent', 'ETL__SSID_AV_performance_id', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimEventHeader', 'etl.vw_Load_AV_DimEventHeader', 'AV_series_id', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimItem', 'etl.vw_Load_AV_DimItem', 'ETL__SSID_AV_miscellaneousitem_ID', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimPlan', 'etl.vw_Load_AV_DimPlan', 'ETL__SSID_AV_bundle_ID', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimPriceChart', 'etl.vw_Load_AV_DimPriceChart', 'ETL__SSID', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimPriceLevel', 'etl.vw_Load_AV_DimPriceLevel', 'ETL__SSID_AV_value_legend_id', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimPriceType', 'etl.vw_Load_AV_DimPriceType', 'ETL__SSID_AV_price_type_id', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimPromo', 'etl.vw_Load_AV_DimPromo', 'ETL__SSID_AV_promo_code_ID', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimSeason', 'etl.vw_Load_AV_DimSeason', 'ETL__SSID_AV_season', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimSeat', 'etl.vw_Load_AV_DimSeat', 'ETL__SSID_AV_venue_ID, ETL__SSID_AV_seat_ID, ETL__SSID_AV_section_ID', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimTicketCustomer', 'etl.vw_Load_AV_DimTicketCustomer', 'ETL__SSID_AV_customer_id', 'AV'

	EXEC [etl].[SSB_StandardModelLoad] '00000000-0000-0000-0000-000000000000', 'etl.vw_DimPriceLevel', 'etl.vw_Load_AV_DimPriceLevel', 'ETL__SSID_AV_value_legend_id', 'AV'

END




GO
