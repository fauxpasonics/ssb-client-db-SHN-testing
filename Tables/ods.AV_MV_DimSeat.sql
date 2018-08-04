CREATE TABLE [ods].[AV_MV_DimSeat]
(
[ETL__SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_AV_venue_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_SSID_AV_seat_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_SSID_AV_section_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LevelName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SectionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Seat] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrderLevel] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrderSection] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrderRow] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrderSeat] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SectionDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_IsFactInventoryEligible] [int] NOT NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL,
[AV_section_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AV_sys_section] [int] NULL,
[AV_sys_row] [int] NULL,
[AV_sys_seat] [int] NULL,
[AV_venue_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
