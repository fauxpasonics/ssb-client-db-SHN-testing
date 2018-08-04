CREATE TABLE [bkp].[AV_ts_message_delivery]
(
[audit_datetime] [datetime] NULL,
[messagedelivery_record_state] [int] NOT NULL,
[messagedelivery_audit_id] [uniqueidentifier] NOT NULL,
[messagedelivery_create_audit_id] [uniqueidentifier] NULL,
[messagedelivery_id] [uniqueidentifier] NOT NULL,
[messagedelivery_message_id] [uniqueidentifier] NOT NULL,
[messagedelivery_delivery_count] [int] NULL,
[messagedelivery_last_delivered] [datetime] NULL,
[messagedelivery_version] [int] NULL,
[messagedelivery_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
