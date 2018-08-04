CREATE TABLE [bkp].[AV_ts_series_performance_type]
(
[audit_datetime] [datetime] NULL,
[seriesperformancetype_record_state] [int] NOT NULL,
[seriesperformancetype_audit_id] [uniqueidentifier] NOT NULL,
[seriesperformancetype_create_audit_id] [uniqueidentifier] NULL,
[seriesperformancetype_fill_template_id] [uniqueidentifier] NULL,
[seriesperformancetype_hold_template_id] [uniqueidentifier] NULL,
[seriesperformancetype_id] [uniqueidentifier] NOT NULL,
[seriesperformancetype_performance_type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[seriesperformancetype_price_template_id] [uniqueidentifier] NULL,
[seriesperformancetype_series_id] [uniqueidentifier] NOT NULL,
[seriesperformancetype_version] [int] NOT NULL,
[seriesperformancetype_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
