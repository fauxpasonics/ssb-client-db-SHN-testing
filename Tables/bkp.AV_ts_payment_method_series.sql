CREATE TABLE [bkp].[AV_ts_payment_method_series]
(
[audit_datetime] [datetime] NULL,
[paymentseries_record_state] [int] NOT NULL,
[paymentseries_audit_id] [uniqueidentifier] NULL,
[paymentseries_create_audit_id] [uniqueidentifier] NULL,
[paymentseries_payment_method_id] [uniqueidentifier] NOT NULL,
[paymentseries_series_id] [uniqueidentifier] NOT NULL,
[paymentseries_version] [int] NULL,
[paymentseries_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
