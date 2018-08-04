CREATE TABLE [bkp].[AV_ts_price_chart_performance]
(
[audit_datetime] [datetime] NULL,
[pricechartperformance_record_state] [int] NOT NULL,
[pricechartperformance_audit_id] [uniqueidentifier] NULL,
[pricechartperformance_create_audit_id] [uniqueidentifier] NULL,
[pricechartperformance_assignment_id] [uniqueidentifier] NOT NULL,
[pricechartperformance_performance_id] [uniqueidentifier] NOT NULL,
[pricechartperformance_version] [int] NOT NULL,
[pricechartperformance_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
