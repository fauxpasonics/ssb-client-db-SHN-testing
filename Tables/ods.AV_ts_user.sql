CREATE TABLE [ods].[AV_ts_user]
(
[user_record_state] [int] NOT NULL,
[user_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_change_date] [datetime] NULL,
[user_contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_end_date] [datetime] NULL,
[user__id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_language] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_logon_failure_limit] [int] NULL,
[user__name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[user_override_timeout] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_start_date] [datetime] NULL,
[user_version] [int] NOT NULL,
[user_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_default_dashboard_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_default_role_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
