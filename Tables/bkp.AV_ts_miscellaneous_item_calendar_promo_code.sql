CREATE TABLE [bkp].[AV_ts_miscellaneous_item_calendar_promo_code]
(
[audit_datetime] [datetime] NULL,
[miscellaneousitemcalendarpromocode_record_state] [int] NOT NULL,
[miscellaneousitemcalendarpromocode_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemcalendarpromocode_create_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemcalendarpromocode_miscellaneousitemcalendar_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemcalendarpromocode_promocode_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemcalendarpromocode_version] [int] NULL,
[miscellaneousitemcalendarpromocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
