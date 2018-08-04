CREATE TABLE [bkp].[AV_ts_seat_template_value]
(
[audit_datetime] [datetime] NULL,
[seattemplatevalue_seat_template_id] [uniqueidentifier] NOT NULL,
[seattemplatevalue_value_legend_id] [uniqueidentifier] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
