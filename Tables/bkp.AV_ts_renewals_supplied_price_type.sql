CREATE TABLE [bkp].[AV_ts_renewals_supplied_price_type]
(
[audit_datetime] [datetime] NULL,
[renewalssuppliedpricetype_record_state] [int] NOT NULL,
[renewalssuppliedpricetype_audit_id] [uniqueidentifier] NOT NULL,
[renewalssuppliedpricetype_create_audit_id] [uniqueidentifier] NULL,
[renewalssuppliedpricetype_id] [uniqueidentifier] NOT NULL,
[renewalssuppliedpricetype_renewalsseatrules_id] [uniqueidentifier] NOT NULL,
[renewalssuppliedpricetype_price_type_id] [uniqueidentifier] NOT NULL,
[renewalssuppliedpricetype_quantity] [int] NULL,
[renewalssuppliedpricetype_version] [int] NOT NULL,
[renewalssuppliedpricetype_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
