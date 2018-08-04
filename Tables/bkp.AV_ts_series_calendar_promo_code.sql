CREATE TABLE [bkp].[AV_ts_series_calendar_promo_code]
(
[audit_datetime] [datetime] NULL,
[seriescalendarpromocode_record_state] [int] NOT NULL,
[seriescalendarpromocode_audit_id] [uniqueidentifier] NULL,
[seriescalendarpromocode_create_audit_id] [uniqueidentifier] NULL,
[seriescalendarpromocode_seriescalendar_id] [uniqueidentifier] NOT NULL,
[seriescalendarpromocode_promocode_id] [uniqueidentifier] NOT NULL,
[seriescalendarpromocode_version] [int] NULL,
[seriescalendarpromocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
