CREATE TABLE [bkp].[AV_ts_bundle_version_membership]
(
[audit_datetime] [datetime] NULL,
[bundlevermembership_record_state] [int] NOT NULL,
[bundlevermembership_audit_id] [uniqueidentifier] NULL,
[bundlevermembership_create_audit_id] [uniqueidentifier] NULL,
[bundlevermembership_id] [uniqueidentifier] NOT NULL,
[bundlevermembership_membership_id] [uniqueidentifier] NOT NULL,
[bundlevermembership_points] [int] NULL,
[bundlevermembership_bundle_version_id] [uniqueidentifier] NOT NULL,
[bundlevermembership_version] [int] NULL,
[bundlevermembership_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
