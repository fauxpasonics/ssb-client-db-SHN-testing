CREATE TABLE [bkp].[AV_ts_renewals]
(
[audit_datetime] [datetime] NULL,
[renewals_record_state] [int] NOT NULL,
[renewals_audit_id] [uniqueidentifier] NOT NULL,
[renewals_create_audit_id] [uniqueidentifier] NULL,
[renewals_id] [uniqueidentifier] NOT NULL,
[renewals_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[renewals_offer_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewals_type] [int] NOT NULL,
[renewals_start_date] [datetime] NULL,
[renewals_end_date] [datetime] NULL,
[renewals_balance_due_date] [datetime] NULL,
[renewals_entered_promo_code] [uniqueidentifier] NULL,
[renewals_description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewals_delivery_method_id] [uniqueidentifier] NULL,
[renewals_unpaid_reason] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewals_order_type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewals_order_list] [uniqueidentifier] NULL,
[renewals_version] [int] NOT NULL,
[renewals_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewals_options] [int] NULL,
[renewals_payment_method_id] [uniqueidentifier] NULL,
[renewals_payment_type] [int] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
