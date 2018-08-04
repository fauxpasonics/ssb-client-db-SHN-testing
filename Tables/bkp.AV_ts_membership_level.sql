CREATE TABLE [bkp].[AV_ts_membership_level]
(
[audit_datetime] [datetime] NULL,
[membership_level_record_state] [int] NOT NULL,
[membership_level_audit_id] [uniqueidentifier] NOT NULL,
[membership_level_create_audit_id] [uniqueidentifier] NOT NULL,
[membership_level_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[membership_level_full_points_required] [bigint] NULL,
[membership_level_id] [uniqueidentifier] NOT NULL,
[membership_level_membership_version_id] [uniqueidentifier] NULL,
[membership_level_minimum_points_required] [bigint] NULL,
[membership_level_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[membership_level_version] [int] NOT NULL,
[membership_level_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
