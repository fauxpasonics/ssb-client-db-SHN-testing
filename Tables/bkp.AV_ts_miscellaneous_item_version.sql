CREATE TABLE [bkp].[AV_ts_miscellaneous_item_version]
(
[audit_datetime] [datetime] NULL,
[miscitemver_record_state] [int] NOT NULL,
[miscitemver_audit_id] [uniqueidentifier] NULL,
[miscitemver_create_audit_id] [uniqueidentifier] NULL,
[miscitemver_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[miscitemver_end_date] [datetime] NULL,
[miscitemver_id] [uniqueidentifier] NOT NULL,
[miscitemver_miscellaneous_item_id] [uniqueidentifier] NOT NULL,
[miscitemver_start_date] [datetime] NULL,
[miscitemver_membership_id] [uniqueidentifier] NULL,
[miscitemver_assigned_pass_id] [uniqueidentifier] NULL,
[miscitemver_points] [bigint] NULL,
[miscitemver_version] [int] NULL,
[miscitemver_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
