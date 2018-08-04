CREATE TABLE [ods].[AV_MV_DimEventHeader]
(
[EventCode] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventDesc] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventOpenTime] [datetime] NULL,
[EventFinishTime] [datetime] NULL,
[IsSportingEvent] [int] NOT NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL,
[IsDeleted] [int] NOT NULL,
[AV_series_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_venue_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data1] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data2] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data3] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data4] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data5] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data6] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data7] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data8] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_group] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_caps_customer_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_AV_series_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
