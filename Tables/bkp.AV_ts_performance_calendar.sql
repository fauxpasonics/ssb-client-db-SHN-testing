CREATE TABLE [bkp].[AV_ts_performance_calendar]
(
[audit_datetime] [datetime] NULL,
[performancecalendar_record_state] [int] NOT NULL,
[performancecalendar_audit_id] [uniqueidentifier] NOT NULL,
[performancecalendar_create_audit_id] [uniqueidentifier] NULL,
[performancecalendar_id] [uniqueidentifier] NOT NULL,
[performancecalendar_off_cal] [datetime] NULL,
[performancecalendar_off_sale] [datetime] NULL,
[performancecalendar_on_cal] [datetime] NULL,
[performancecalendar_on_sale] [datetime] NULL,
[performancecalendar_performance_id] [uniqueidentifier] NOT NULL,
[performancecalendar_on_offer_timeout] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[performancecalendar_version] [int] NOT NULL,
[performancecalendar_reservation_timeout] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[performancecalendar_reservation_valid_until] [datetime] NULL,
[performancecalendar_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
