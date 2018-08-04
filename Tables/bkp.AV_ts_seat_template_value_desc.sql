CREATE TABLE [bkp].[AV_ts_seat_template_value_desc]
(
[audit_datetime] [datetime] NULL,
[stvd_record_state] [int] NOT NULL,
[stvd_audit_id] [uniqueidentifier] NOT NULL,
[stvd_create_audit_id] [uniqueidentifier] NULL,
[stvd_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[stvd_id] [uniqueidentifier] NOT NULL,
[stvd_seat_template_id] [uniqueidentifier] NOT NULL,
[stvd_value_id] [uniqueidentifier] NOT NULL,
[stvd_version] [int] NOT NULL,
[stvd_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
