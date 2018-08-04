CREATE TABLE [bkp].[AV_ts_bundle_admission_performance]
(
[audit_datetime] [datetime] NULL,
[bundleadmperf_record_state] [int] NOT NULL,
[bundleadmperf_audit_id] [uniqueidentifier] NOT NULL,
[bundleadmperf_bundle_admission_id] [uniqueidentifier] NOT NULL,
[bundleadmperf_create_audit_id] [uniqueidentifier] NULL,
[bundleadmperf_performance_id] [uniqueidentifier] NOT NULL,
[bundleadmperf_version] [int] NULL,
[bundleadmperf_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
