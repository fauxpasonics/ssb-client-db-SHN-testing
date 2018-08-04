CREATE TABLE [bkp].[AV_ts_miscellaneous_item_calendar]
(
[audit_datetime] [datetime] NULL,
[miscellaneousitemcalendar_record_state] [int] NOT NULL,
[miscellaneousitemcalendar_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemcalendar_create_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemcalendar_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemcalendar_off_sale] [datetime] NULL,
[miscellaneousitemcalendar_on_sale] [datetime] NULL,
[miscellaneousitemcalendar_miscellaneous_item_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemcalendar_version] [int] NULL,
[miscellaneousitemcalendar_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
