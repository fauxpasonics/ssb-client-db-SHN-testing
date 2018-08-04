CREATE TABLE [ods].[AV_ts_address]
(
[address_record_state] [int] NOT NULL,
[address_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_city] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_country] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_CP_sort] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_end_date] [datetime] NULL,
[address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_parent_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_parent_table] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_start_date] [datetime] NULL,
[address_state] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_street] [nvarchar] (122) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_type] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_verification_state] [int] NULL,
[address_version] [int] NOT NULL,
[address_zip] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[change_of_address_status] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
