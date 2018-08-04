CREATE TABLE [bkp].[AV_ts_bundleversion]
(
[audit_datetime] [datetime] NULL,
[bundleversion_record_state] [int] NOT NULL,
[bundleversion_audit_id] [uniqueidentifier] NOT NULL,
[bundleversion_bundle_id] [uniqueidentifier] NOT NULL,
[bundleversion_create_audit_id] [uniqueidentifier] NULL,
[bundleversion_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_effective_date] [datetime] NOT NULL,
[bundleversion_effective_date_end] [datetime] NULL,
[bundleversion_max_instances] [int] NULL,
[bundleversion_min_performances] [int] NULL,
[bundleversion_max_performances] [int] NULL,
[bundleversion_min_admissions_performance] [int] NULL,
[bundleversion_max_admissions_performance] [int] NULL,
[bundleversion_total] [bigint] NULL,
[bundleversion_version] [int] NULL,
[bundleversion_version_id] [uniqueidentifier] NOT NULL,
[bundleversion_assigned_pass_id] [uniqueidentifier] NULL,
[bundleversion_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
