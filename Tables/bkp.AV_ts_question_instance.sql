CREATE TABLE [bkp].[AV_ts_question_instance]
(
[audit_datetime] [datetime] NULL,
[questioninstance_record_state] [int] NOT NULL,
[questioninstance_audit_id] [uniqueidentifier] NULL,
[questioninstance_create_audit_id] [uniqueidentifier] NULL,
[questioninstance_performance_id] [uniqueidentifier] NOT NULL,
[questioninstance_order_id] [uniqueidentifier] NOT NULL,
[questioninstance_question_id] [uniqueidentifier] NOT NULL,
[questioninstance_id] [uniqueidentifier] NOT NULL,
[questioninstance_version] [int] NULL,
[questioninstance_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
