CREATE TABLE [bkp].[AV_ts_lists]
(
[list_record_state] [int] NULL,
[list_audit_id] [uniqueidentifier] NULL,
[list_create_audit_id] [uniqueidentifier] NULL,
[list_id] [uniqueidentifier] NULL,
[list_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_sort_order] [int] NULL,
[list_version] [int] NULL,
[list_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
