CREATE TABLE [bkp].[AV_ts_price_chart]
(
[audit_datetime] [datetime] NULL,
[pricechart_record_state] [int] NOT NULL,
[pricechart_id] [uniqueidentifier] NOT NULL,
[pricechart_name] [nvarchar] (210) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[pricechart_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_audit_id] [uniqueidentifier] NULL,
[pricechart_create_audit_id] [uniqueidentifier] NULL,
[pricechart_version] [int] NULL,
[pricechart_short_description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricechart_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
