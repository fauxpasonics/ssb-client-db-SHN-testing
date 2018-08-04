CREATE TABLE [dbo].[FactInventory_V2]
(
[FactInventoryId] [bigint] NOT NULL IDENTITY(1, 1),
[ETL__SourceSystem] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[DimArenaId] [int] NOT NULL,
[DimSeasonId] [int] NOT NULL,
[DimEventId] [int] NOT NULL,
[DimSeatId] [int] NOT NULL,
[DimSeatStatusId] [int] NOT NULL,
[SeatValue] [decimal] (18, 6) NULL,
[FactTicketSalesId] [bigint] NULL,
[FactAttendanceId] [bigint] NULL,
[FactTicketActivityId_Resold] [bigint] NULL,
[FactTicketActivityId_Tranferred] [bigint] NULL,
[FactOdetId] [bigint] NULL,
[ETL__SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FactAvailSeatsId] [bigint] NULL,
[FactHeldSeatsId] [bigint] NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [CCI_dbo__FactInventory_V2] ON [dbo].[FactInventory_V2]
GO
