CREATE TABLE [bkp].[AV_ts_seat]
(
[audit_datetime] [datetime] NULL,
[seat_record_state] [int] NOT NULL,
[seat_id] [uniqueidentifier] NOT NULL,
[seat_venue_id] [uniqueidentifier] NOT NULL,
[seat_pl_x_pos] [bigint] NULL,
[seat_pl_y_pos] [bigint] NULL,
[seat_pl_z_pos] [bigint] NULL,
[seat_venue_screen_id] [uniqueidentifier] NULL,
[seat_version] [int] NULL,
[seat_audit_id] [uniqueidentifier] NULL,
[seat_create_audit_id] [uniqueidentifier] NULL,
[seat_section_id] [uniqueidentifier] NOT NULL,
[seat_row] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_seat] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_aisle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_sys_section] [int] NULL,
[seat_sys_row] [int] NULL,
[seat_sys_seat] [int] NULL,
[seat_sys_type] [int] NULL,
[seat_message] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_image] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
