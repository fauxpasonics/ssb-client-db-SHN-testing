CREATE TABLE [bkp].[AV_ts_customer_benefit]
(
[audit_datetime] [datetime] NULL,
[customer_benefit_record_state] [int] NOT NULL,
[customer_benefit_assigned_date] [datetime] NULL,
[customer_benefit_audit_id] [uniqueidentifier] NOT NULL,
[customer_benefit_benefit_id] [uniqueidentifier] NOT NULL,
[customer_benefit_create_audit_id] [uniqueidentifier] NOT NULL,
[customer_benefit_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_benefit_customer_id] [uniqueidentifier] NOT NULL,
[customer_benefit_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_benefit_financial_value] [bigint] NULL,
[customer_benefit_id] [uniqueidentifier] NOT NULL,
[customer_benefit_customer_membership_id] [uniqueidentifier] NULL,
[customer_benefit_start_date] [datetime] NULL,
[customer_benefit_valid_until_date] [datetime] NULL,
[customer_benefit_version] [int] NOT NULL,
[customer_benefit_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
