CREATE TABLE [bkp].[AV_ts_price_charge_price_type]
(
[audit_datetime] [datetime] NULL,
[pricechargepricetype_record_state] [int] NOT NULL,
[pricechargepricetype_audit_id] [uniqueidentifier] NULL,
[pricechargepricetype_create_audit_id] [uniqueidentifier] NULL,
[pricechargepricetype_pricecharge_id] [uniqueidentifier] NOT NULL,
[pricechargepricetype_price_type_id] [uniqueidentifier] NOT NULL,
[pricechargepricetype_version] [int] NOT NULL,
[pricechargepricetype_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
