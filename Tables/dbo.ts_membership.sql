CREATE TABLE [dbo].[ts_membership]
(
[membership_record_state] [int] NOT NULL,
[membership_audit_id] [uniqueidentifier] NOT NULL,
[membership_create_audit_id] [uniqueidentifier] NOT NULL,
[membership_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[membership_id] [uniqueidentifier] NOT NULL,
[membership_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[membership_version] [int] NOT NULL,
[membership_type] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[membership_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
