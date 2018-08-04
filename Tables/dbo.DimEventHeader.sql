CREATE TABLE [dbo].[DimEventHeader]
(
[DimEventHeaderId] [int] NOT NULL IDENTITY(1, 1),
[ETL__SourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__IsDeleted] [bit] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SSID_AV_series_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DimSeasonHeaderId] [int] NOT NULL,
[DimTeamId_Opponent] [int] NOT NULL,
[DimGameInfoId] [int] NOT NULL,
[EventCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDesc] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventClass] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [date] NULL,
[EventTime] [time] NULL,
[EventDateTime] [datetime] NULL,
[EventOpenTime] [datetime] NULL,
[EventFinishTime] [datetime] NULL,
[IsSportingEvent] [bit] NULL,
[GameType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GameTypeNumber] [int] NULL,
[SeasonEventNumber] [int] NULL,
[HomeGameNumber] [int] NULL,
[EventHierarchyL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventHierarchyL2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventHierarchyL3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventHierarchyL4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventHierarchyL5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_venue_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data6] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data7] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_data8] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AV_series_caps_customer_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL,
[Config_Category1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_Int_1] [int] NULL,
[Custom_Int_2] [int] NULL,
[Custom_Int_3] [int] NULL,
[Custom_Int_4] [int] NULL,
[Custom_Int_5] [int] NULL,
[Custom_Dec_1] [decimal] (18, 6) NULL,
[Custom_Dec_2] [decimal] (18, 6) NULL,
[Custom_Dec_3] [decimal] (18, 6) NULL,
[Custom_Dec_4] [decimal] (18, 6) NULL,
[Custom_Dec_5] [decimal] (18, 6) NULL,
[Custom_DateTime_1] [datetime] NULL,
[Custom_DateTime_2] [datetime] NULL,
[Custom_DateTime_3] [datetime] NULL,
[Custom_DateTime_4] [datetime] NULL,
[Custom_DateTime_5] [datetime] NULL,
[Custom_Bit_1] [bit] NULL,
[Custom_Bit_2] [bit] NULL,
[Custom_Bit_3] [bit] NULL,
[Custom_Bit_4] [bit] NULL,
[Custom_Bit_5] [bit] NULL,
[Custom_nVarChar_1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[DimEventHeader] ADD CONSTRAINT [PK_dbo__DimEventHeader] PRIMARY KEY CLUSTERED  ([DimEventHeaderId])
GO