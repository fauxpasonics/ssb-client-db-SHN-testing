CREATE TABLE [ods].[AV_ts_bundleversion]
(
[bundleversion_record_state] [int] NULL,
[bundleversion_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_bundle_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_effective_date] [datetime] NULL,
[bundleversion_effective_date_end] [datetime] NULL,
[bundleversion_max_instances] [int] NULL,
[bundleversion_min_performances] [int] NULL,
[bundleversion_max_performances] [int] NULL,
[bundleversion_min_admissions_performance] [int] NULL,
[bundleversion_max_admissions_performance] [int] NULL,
[bundleversion_total] [bigint] NULL,
[bundleversion_version] [int] NULL,
[bundleversion_version_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_assigned_pass_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleversion_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
