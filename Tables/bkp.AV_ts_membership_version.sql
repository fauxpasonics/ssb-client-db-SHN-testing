CREATE TABLE [bkp].[AV_ts_membership_version]
(
[audit_datetime] [datetime] NULL,
[membershipversion_record_state] [int] NOT NULL,
[membershipversion_audit_id] [uniqueidentifier] NOT NULL,
[membershipversion_create_audit_id] [uniqueidentifier] NOT NULL,
[membershipversion_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[membershipversion_end_date] [datetime] NULL,
[membershipversion_valid_to] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[membershipversion_valid_from] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[membershipversion_id] [uniqueidentifier] NOT NULL,
[membershipversion_membership_id] [uniqueidentifier] NOT NULL,
[membershipversion_start_date] [datetime] NULL,
[membershipversion_version] [int] NOT NULL,
[membershipversion_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
