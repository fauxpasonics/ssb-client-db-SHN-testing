CREATE TABLE [bkp].[AV_ts_order_comments]
(
[audit_datetime] [datetime] NULL,
[ordercomments_record_state] [int] NOT NULL,
[ordercomments_id] [uniqueidentifier] NOT NULL,
[ordercomments_order_id] [uniqueidentifier] NOT NULL,
[ordercomments_comments] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ordercomments_audit_id] [uniqueidentifier] NULL,
[ordercomments_create_audit_id] [uniqueidentifier] NULL,
[ordercomments_version] [int] NULL,
[ordercomments_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
