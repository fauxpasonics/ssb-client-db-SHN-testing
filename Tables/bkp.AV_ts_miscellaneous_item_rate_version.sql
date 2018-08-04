CREATE TABLE [bkp].[AV_ts_miscellaneous_item_rate_version]
(
[audit_datetime] [datetime] NULL,
[miscellaneousrate_record_state] [int] NOT NULL,
[miscellaneousrate_audit_id] [uniqueidentifier] NULL,
[miscellaneousrate_create_audit_id] [uniqueidentifier] NULL,
[miscellaneousrate_amount] [bigint] NULL,
[miscellaneousrate_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[miscellaneousrate_id] [uniqueidentifier] NOT NULL,
[miscellaneousrate_miscellaneous_item_version_id] [uniqueidentifier] NOT NULL,
[miscellaneousrate_version] [int] NULL,
[miscellaneousrate_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[miscellaneousrate_options] [int] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
