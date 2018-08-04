CREATE TABLE [bkp].[AV_ts_price_chart_zone]
(
[audit_datetime] [datetime] NULL,
[pricechartzone_record_state] [int] NOT NULL,
[pricechartzone_chart_id] [uniqueidentifier] NOT NULL,
[pricechartzone_zone_id] [uniqueidentifier] NOT NULL,
[pricechartzone_audit_id] [uniqueidentifier] NULL,
[pricechartzone_create_audit_id] [uniqueidentifier] NULL,
[pricechartzone_version] [int] NULL,
[pricechartzone_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
