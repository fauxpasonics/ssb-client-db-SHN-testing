CREATE TABLE [dbo].[FactTicketActivity_V2]
(
[FactTicketActivityId] [bigint] NOT NULL IDENTITY(1, 1),
[ETL__SourceSystem] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__IsDeleted] [bit] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DimDateId] [int] NOT NULL,
[DimTimeId] [int] NOT NULL,
[DimArenaId] [int] NOT NULL,
[DimSeasonId] [int] NOT NULL,
[DimItemId] [int] NOT NULL,
[DimEventId] [int] NOT NULL,
[DimPlanId] [int] NOT NULL,
[DimSeatId_Start] [int] NOT NULL,
[DimTicketCustomerId] [bigint] NOT NULL,
[DimTicketCustomerId_Recipient] [bigint] NOT NULL,
[DimActivityId] [int] NOT NULL,
[TransDateTime] [datetime] NULL,
[QtySeat] [int] NULL,
[SubTotal] [decimal] (18, 6) NULL,
[Fees] [decimal] (18, 6) NULL,
[Taxes] [decimal] (18, 6) NULL,
[Total] [decimal] (18, 6) NULL,
[CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [CCI_dbo__FactTicketActivity_V2] ON [dbo].[FactTicketActivity_V2]
GO
