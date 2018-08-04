CREATE TABLE [bkp].[AV_ts_section]
(
[audit_datetime] [datetime] NULL,
[section_record_state] [int] NOT NULL,
[section_audit_id] [uniqueidentifier] NULL,
[section_create_audit_id] [uniqueidentifier] NULL,
[section_id] [uniqueidentifier] NOT NULL,
[section_venue_id] [uniqueidentifier] NOT NULL,
[section_name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[section_description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_stand] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_level] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_entrance] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_url] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_message] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_version] [int] NULL,
[section_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
