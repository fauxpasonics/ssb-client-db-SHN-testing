CREATE TABLE [bkp].[AV_ts_customer_account_balance]
(
[audit_datetime] [datetime] NULL,
[customeraccountbalance_record_state] [int] NOT NULL,
[customeraccountbalance_amount] [bigint] NULL,
[customeraccountbalance_audit_id] [uniqueidentifier] NOT NULL,
[customeraccountbalance_create_audit_id] [uniqueidentifier] NULL,
[customeraccountbalance_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customeraccountbalance_customer_id] [uniqueidentifier] NOT NULL,
[customeraccountbalance_id] [uniqueidentifier] NOT NULL,
[customeraccountbalance_version] [int] NULL,
[customeraccountbalance_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
