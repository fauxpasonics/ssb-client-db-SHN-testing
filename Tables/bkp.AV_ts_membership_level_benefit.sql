CREATE TABLE [bkp].[AV_ts_membership_level_benefit]
(
[audit_datetime] [datetime] NULL,
[membershipbenefit_record_state] [int] NOT NULL,
[membershipbenefit_audit_id] [uniqueidentifier] NULL,
[membershipbenefit_benefit_id] [uniqueidentifier] NOT NULL,
[membershipbenefit_create_audit_id] [uniqueidentifier] NULL,
[membershipbenefit_membership_level_id] [uniqueidentifier] NOT NULL,
[membershipbenefit_version] [int] NULL,
[membershipbenefit_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
