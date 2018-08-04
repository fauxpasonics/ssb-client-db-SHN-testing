CREATE TABLE [bkp].[AV_ts_price_charge]
(
[audit_datetime] [datetime] NULL,
[pricecharge_record_state] [int] NOT NULL,
[pricecharge_id] [uniqueidentifier] NOT NULL,
[pricecharge_pricechart_id] [uniqueidentifier] NOT NULL,
[pricecharge_calculation_type] [int] NOT NULL,
[pricecharge_audit_id] [uniqueidentifier] NULL,
[pricecharge_create_audit_id] [uniqueidentifier] NULL,
[pricecharge_version] [int] NULL,
[pricecharge_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
