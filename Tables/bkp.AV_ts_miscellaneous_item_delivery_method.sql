CREATE TABLE [bkp].[AV_ts_miscellaneous_item_delivery_method]
(
[audit_datetime] [datetime] NULL,
[miscellaneousitemdeliverymethod_record_state] [int] NOT NULL,
[miscellaneousitemdeliverymethod_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemdeliverymethod_create_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemdeliverymethod_miscellaneous_item_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemdeliverymethod_delivery_method_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemdeliverymethod_version] [int] NOT NULL,
[miscellaneousitemdeliverymethod_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
