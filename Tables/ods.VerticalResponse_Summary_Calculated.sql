CREATE TABLE [ods].[VerticalResponse_Summary_Calculated]
(
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeliveryCount] [int] NOT NULL,
[MinDeliveryDate] [datetime] NULL,
[MaxDeliveryDate] [datetime] NULL,
[DaysSinceLastDelivery] [int] NULL,
[OpenCount] [int] NOT NULL,
[MinOpenDate] [datetime] NULL,
[MaxOpenDate] [datetime] NULL,
[DaysSinceLastOpen] [int] NULL,
[ClickCount] [int] NOT NULL,
[MinClickDate] [datetime] NULL,
[MaxClickDate] [datetime] NULL,
[DaysSinceLastClick] [int] NULL,
[BounceCount] [int] NOT NULL,
[MinBounceDate] [datetime] NULL,
[MaxBounceDate] [datetime] NULL,
[DaysSinceLastBounce] [int] NULL,
[UnsubCount] [int] NOT NULL,
[MinUnsubDate] [datetime] NULL,
[MaxUnsubDate] [datetime] NULL,
[DaysSinceLastUnsub] [int] NULL,
[ETL__UpdatedDate] [datetime] NOT NULL
)
GO
