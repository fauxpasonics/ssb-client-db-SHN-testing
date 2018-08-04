CREATE TABLE [bkp].[AV_ts_seat_template_seat]
(
[audit_datetime] [datetime] NULL,
[seattempseat_record_state] [int] NOT NULL,
[seattempseat_seat_template_id] [uniqueidentifier] NOT NULL,
[seattempseat_template_id] [uniqueidentifier] NOT NULL,
[seattempseat_seat_id] [uniqueidentifier] NOT NULL,
[seattempseat_template_value_id] [uniqueidentifier] NOT NULL,
[seattempseat_version] [int] NULL,
[seattempseat_audit_id] [uniqueidentifier] NULL,
[seattempseat_create_audit_id] [uniqueidentifier] NULL,
[seattempseat_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
