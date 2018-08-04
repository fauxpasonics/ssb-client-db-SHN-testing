CREATE TABLE [ods].[AV_ts_value_legend]
(
[value_legend_record_state] [int] NOT NULL,
[value_legend_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_colour] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_create_audit_id] [uniqueidentifier] NULL,
[value_legend_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_label] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[value_legend_value] [bigint] NULL,
[value_legend_version] [int] NOT NULL,
[value_legend_message] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value_legend_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
