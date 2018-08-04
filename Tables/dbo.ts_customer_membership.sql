CREATE TABLE [dbo].[ts_customer_membership]
(
[customermembership_record_state] [int] NOT NULL,
[customermembership_audit_id] [uniqueidentifier] NULL,
[customermembership_create_audit_id] [uniqueidentifier] NULL,
[customermembership_id] [uniqueidentifier] NOT NULL,
[customermembership_customer_id] [uniqueidentifier] NOT NULL,
[customermembership_start_date] [datetime] NULL,
[customermembership_expiry_date] [datetime] NULL,
[customermembership_membership_id] [uniqueidentifier] NOT NULL,
[customermembership_membership_level_id] [uniqueidentifier] NULL,
[customermembership_version] [int] NULL,
[customermembership_points_total] [bigint] NULL,
[customermembership_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
