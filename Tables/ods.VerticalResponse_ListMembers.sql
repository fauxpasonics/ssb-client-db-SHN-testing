CREATE TABLE [ods].[VerticalResponse_ListMembers]
(
[ListID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UnsubCampaignID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Number] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpecialNumber] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustNum] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeriesName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeriesNameB] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderNumA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderNumB] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderNumC] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderNumD] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderNumE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DueDate1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AmtDue1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AmtDue2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AmtDue3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatLocations] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Classification] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BounceCampaignID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Restricted] [int] NULL,
[IsCassCertified] [int] NULL,
[Impressions] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OptInStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OptInStatusLastUpdated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [ods].[VerticalResponse_ListMembers] ADD CONSTRAINT [PK__Vertical__6F9CA5A09BC79F37] PRIMARY KEY CLUSTERED  ([ListID], [CID])
GO
