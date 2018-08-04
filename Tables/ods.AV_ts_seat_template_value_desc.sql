CREATE TABLE [ods].[AV_ts_seat_template_value_desc]
(
[stvd_record_state] [int] NOT NULL,
[stvd_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stvd_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stvd_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[stvd_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stvd_seat_template_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stvd_value_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stvd_version] [int] NOT NULL,
[stvd_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
