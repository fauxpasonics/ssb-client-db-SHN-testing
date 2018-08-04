CREATE TABLE [bkp].[AV_ts_bundle_calendar]
(
[audit_datetime] [datetime] NULL,
[bundlecalendar_record_state] [int] NOT NULL,
[bundlecalendar_audit_id] [uniqueidentifier] NOT NULL,
[bundlecalendar_bundle_id] [uniqueidentifier] NOT NULL,
[bundlecalendar_create_audit_id] [uniqueidentifier] NULL,
[bundlecalendar_id] [uniqueidentifier] NOT NULL,
[bundlecalendar_off_cal] [datetime] NULL,
[bundlecalendar_off_cal_override_flag] [int] NULL,
[bundlecalendar_off_sale] [datetime] NULL,
[bundlecalendar_off_sale_override_flag] [int] NULL,
[bundlecalendar_on_cal] [datetime] NULL,
[bundlecalendar_on_cal_override_flag] [int] NULL,
[bundlecalendar_on_sale] [datetime] NULL,
[bundlecalendar_on_sale_override_flag] [int] NULL,
[bundlecalendar_version] [int] NOT NULL,
[bundlecalendar_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
