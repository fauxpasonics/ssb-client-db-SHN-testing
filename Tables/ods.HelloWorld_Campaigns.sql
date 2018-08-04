CREATE TABLE [ods].[HelloWorld_Campaigns]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignID] [int] NULL,
[CampaignName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignMessage] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Recipients] [int] NULL,
[SendDateTime] [datetime] NULL,
[Timestamp] [datetime] NULL
)
GO
ALTER TABLE [ods].[HelloWorld_Campaigns] ADD CONSTRAINT [PK__HelloWor__C4EA2445B2E853E1] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
