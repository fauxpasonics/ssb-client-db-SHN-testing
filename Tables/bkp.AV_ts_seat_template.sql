CREATE TABLE [bkp].[AV_ts_seat_template]
(
[audit_datetime] [datetime] NULL,
[seattemp_record_state] [int] NOT NULL,
[seattemp_audit_id] [uniqueidentifier] NULL,
[seattemp_create_audit_id] [uniqueidentifier] NULL,
[seattemp_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seattemp_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[seattemp_template_id] [uniqueidentifier] NOT NULL,
[seattemp_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seattemp_venue_id] [uniqueidentifier] NOT NULL,
[seattemp_version] [int] NULL,
[seattemp_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
