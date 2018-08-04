CREATE TABLE [ods].[VerticalResponse_EmailCampaigns]
(
[CampaignID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Hash] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tested] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Declined] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FromLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SupportEmail] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SendFriend] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedirectURL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SentSize] [int] NULL,
[CreationDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MailDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AdditionalCosts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TemplateID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [ods].[VerticalResponse_EmailCampaigns] ADD CONSTRAINT [PK__Vertical__3F5E8D7904422CED] PRIMARY KEY CLUSTERED  ([CampaignID])
GO
