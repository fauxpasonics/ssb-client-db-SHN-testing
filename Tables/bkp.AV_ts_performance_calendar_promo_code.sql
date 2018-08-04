CREATE TABLE [bkp].[AV_ts_performance_calendar_promo_code]
(
[audit_datetime] [datetime] NULL,
[performancecalendarpromocode_record_state] [int] NOT NULL,
[performancecalendarpromocode_audit_id] [uniqueidentifier] NULL,
[performancecalendarpromocode_create_audit_id] [uniqueidentifier] NULL,
[performancecalendarpromocode_performancecalendar_id] [uniqueidentifier] NOT NULL,
[performancecalendarpromocode_promocode_id] [uniqueidentifier] NOT NULL,
[performancecalendarpromocode_version] [int] NULL,
[performancecalendarpromocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
