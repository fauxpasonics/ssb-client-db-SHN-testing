CREATE TABLE [ods].[AV_ts_list_entries]
(
[list_entry_record_state] [int] NOT NULL,
[list_entry_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_entry_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_entry_list_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_entry_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_entry_language] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[list_entry_key] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[list_entry_label] [nvarchar] (3000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[list_entry_unique_label] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_entry_sort_hint] [int] NULL,
[list_entry_version] [int] NOT NULL,
[list_entry_status] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[list_entry_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
