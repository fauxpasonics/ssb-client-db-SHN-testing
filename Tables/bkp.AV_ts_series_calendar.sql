CREATE TABLE [bkp].[AV_ts_series_calendar]
(
[audit_datetime] [datetime] NULL,
[seriescalendar_record_state] [int] NOT NULL,
[seriescalendar_audit_id] [uniqueidentifier] NOT NULL,
[seriescalendar_create_audit_id] [uniqueidentifier] NULL,
[seriescalendar_id] [uniqueidentifier] NOT NULL,
[seriescalendar_off_cal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_off_sale] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_on_cal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_on_sale] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_series_id] [uniqueidentifier] NOT NULL,
[seriescalendar_on_offer_timeout] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_version] [int] NOT NULL,
[seriescalendar_reservation_timeout] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_reservation_valid_until] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seriescalendar_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
