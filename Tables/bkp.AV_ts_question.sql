CREATE TABLE [bkp].[AV_ts_question]
(
[audit_datetime] [datetime] NULL,
[question_record_state] [int] NOT NULL,
[question_audit_id] [uniqueidentifier] NULL,
[question_create_audit_id] [uniqueidentifier] NULL,
[question_body] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[question_category] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_default_value] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_id] [uniqueidentifier] NOT NULL,
[question_mode] [int] NULL,
[question_rank] [int] NULL,
[question_response_list] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_subtype] [int] NULL,
[question_total_responses] [int] NULL,
[question_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[question_version] [int] NULL,
[question_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
