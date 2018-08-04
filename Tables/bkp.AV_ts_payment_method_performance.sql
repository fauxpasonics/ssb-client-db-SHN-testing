CREATE TABLE [bkp].[AV_ts_payment_method_performance]
(
[audit_datetime] [datetime] NULL,
[paymentperformance_record_state] [int] NOT NULL,
[paymentperformance_audit_id] [uniqueidentifier] NULL,
[paymentperformance_create_audit_id] [uniqueidentifier] NULL,
[paymentperformance_payment_method_id] [uniqueidentifier] NOT NULL,
[paymentperformance_performance_id] [uniqueidentifier] NOT NULL,
[paymentperformance_version] [int] NULL,
[paymentperformance_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
