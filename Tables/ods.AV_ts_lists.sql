CREATE TABLE [ods].[AV_ts_lists]
(
[list_record_state] [int] NOT NULL,
[list_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[list_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[list_sort_order] [int] NULL,
[list_version] [int] NOT NULL,
[list_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
