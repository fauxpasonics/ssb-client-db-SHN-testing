CREATE TABLE [bkp].[AV_ts_bundleversion_renewalperformance]
(
[audit_datetime] [datetime] NULL,
[bundleversion_renewalperformance_record_state] [int] NOT NULL,
[bundleversion_renewalperformance_bundleversion_id] [uniqueidentifier] NOT NULL,
[bundleversion_renewalperformance_performance_id] [uniqueidentifier] NOT NULL,
[bundleversion_renewalperformance_audit_id] [uniqueidentifier] NULL,
[bundleversion_renewalperformance_create_audit_id] [uniqueidentifier] NULL,
[bundleversion_renewalperformance_version] [int] NOT NULL,
[bundleversion_renewalperformance_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
