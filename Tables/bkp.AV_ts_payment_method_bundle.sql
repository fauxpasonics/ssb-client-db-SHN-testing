CREATE TABLE [bkp].[AV_ts_payment_method_bundle]
(
[audit_datetime] [datetime] NULL,
[paymentbundle_record_state] [int] NOT NULL,
[paymentbundle_audit_id] [uniqueidentifier] NULL,
[paymentbundle_create_audit_id] [uniqueidentifier] NULL,
[paymentbundle_payment_method_id] [uniqueidentifier] NOT NULL,
[paymentbundle_bundle_id] [uniqueidentifier] NOT NULL,
[paymentbundle_version] [int] NULL,
[paymentbundle_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
