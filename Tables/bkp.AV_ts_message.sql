CREATE TABLE [bkp].[AV_ts_message]
(
[audit_datetime] [datetime] NULL,
[message_record_state] [int] NOT NULL,
[message_audit_id] [uniqueidentifier] NOT NULL,
[message_create_audit_id] [uniqueidentifier] NULL,
[message_id] [uniqueidentifier] NOT NULL,
[message_owner] [uniqueidentifier] NOT NULL,
[message_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[message_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_subject] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_from] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_correspondence_code] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_category] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_appeal_id] [uniqueidentifier] NULL,
[message_format] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_body] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_version] [int] NULL,
[message_type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[message_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_communication_preferences] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_marketing_preferences] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_ignore_filtering] [int] NULL,
[message_source] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message_delivery_options] [int] NULL,
[schedule_list] [uniqueidentifier] NOT NULL,
[message_spotlight_until] [datetime] NULL,
[message_extract_template_id] [uniqueidentifier] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
