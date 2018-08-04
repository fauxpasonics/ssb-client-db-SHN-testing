CREATE TABLE [bkp].[AV_ts_renewals_seat_rules]
(
[audit_datetime] [datetime] NULL,
[renewalsseatrules_record_state] [int] NOT NULL,
[renewalsseatrules_audit_id] [uniqueidentifier] NOT NULL,
[renewalsseatrules_create_audit_id] [uniqueidentifier] NULL,
[renewalsseatrules_id] [uniqueidentifier] NOT NULL,
[renewalsseatrules_renewals_id] [uniqueidentifier] NOT NULL,
[renewalsseatrules_source_bundle_id] [uniqueidentifier] NULL,
[renewalsseatrules_dest_bundle_id] [uniqueidentifier] NULL,
[renewalsseatrules_source_performance_id] [uniqueidentifier] NULL,
[renewalsseatrules_price_type_option] [int] NOT NULL,
[renewalsseatrules_seat_hold] [uniqueidentifier] NULL,
[renewalsseatrules_seat_fill] [uniqueidentifier] NULL,
[renewalsseatrules_seat_type] [int] NULL,
[renewalsseatrules_renewal_mapping] [int] NULL,
[renewalsseatrules_version] [int] NOT NULL,
[renewalsseatrules_description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewalsseatrules_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[renewalsseatrules_use_promo] [int] NULL,
[renewalsseatrules_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewalsseatrules_refund_misc_item_id] [uniqueidentifier] NULL,
[renewalsseatrules_refund_rate_amount] [bigint] NULL,
[renewalsseatrules_refund_rate_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewalsseatrules_refund_rate_type] [tinyint] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
