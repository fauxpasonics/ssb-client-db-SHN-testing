CREATE TABLE [stg].[AV_FactAvailSeats]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__SSID] [varchar] (51) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_AV_admission_id] [uniqueidentifier] NULL,
[DimDateId] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DimTimeId] [int] NULL,
[DimArenaId] [int] NULL,
[DimSeasonId] [int] NULL,
[DimItemId] [int] NULL,
[DimEventId] [int] NULL,
[DimPlanId] [int] NULL,
[DimPriceLevelId] [int] NULL,
[DimPriceTypeId] [int] NULL,
[DimPriceCodeId] [int] NULL,
[DimSeatId_Start] [int] NULL,
[DimSeatStatusId] [int] NULL,
[DimPlanTypeId] [int] NULL,
[DimTicketTypeId] [int] NULL,
[DimSeatTypeId] [int] NULL,
[DimTicketClassId] [int] NULL,
[PostedDateTime] [datetime] NULL,
[QtySeat] [int] NULL,
[SubTotal] [decimal] (20, 6) NULL,
[Fees] [decimal] (18, 6) NULL,
[Taxes] [decimal] (18, 6) NULL,
[Total] [decimal] (18, 6) NULL
)
GO
ALTER TABLE [stg].[AV_FactAvailSeats] ADD CONSTRAINT [PK__AV_FactA__C4EA244543924D8C] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
