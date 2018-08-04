CREATE TABLE [ods].[AV_ts_bundle_admission]
(
[bundleadmission_record_state] [int] NOT NULL,
[bundleadmission_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleadmission_bundleversion_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleadmission_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleadmission_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleadmission_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bundleadmission_min_performances] [int] NULL,
[bundleadmission_max_performances] [int] NULL,
[bundleadmission_fulfill_type] [int] NULL,
[bundleadmission_rank] [int] NULL,
[bundleadmission_version] [int] NULL,
[bundleadmission_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[bundleadmission_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
