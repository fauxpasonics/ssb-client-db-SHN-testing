CREATE TABLE [bkp].[AV_ts_bundle_calendar_promo_code]
(
[audit_datetime] [datetime] NULL,
[bundlecalendarpromocode_record_state] [int] NOT NULL,
[bundlecalendarpromocode_audit_id] [uniqueidentifier] NULL,
[bundlecalendarpromocode_create_audit_id] [uniqueidentifier] NULL,
[bundlecalendarpromocode_bundlecalendar_id] [uniqueidentifier] NOT NULL,
[bundlecalendarpromocode_promocode_id] [uniqueidentifier] NOT NULL,
[bundlecalendarpromocode_version] [int] NULL,
[bundlecalendarpromocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
