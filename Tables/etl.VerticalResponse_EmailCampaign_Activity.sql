CREATE TABLE [etl].[VerticalResponse_EmailCampaign_Activity]
(
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ListName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MailDate] [datetime2] NULL,
[DeliveryCount] [int] NULL,
[OpenCount] [int] NULL,
[MinOpenDate] [datetime] NULL,
[MaxOpenDate] [datetime] NULL,
[ClickCount] [int] NULL,
[MinClickDate] [datetime] NULL,
[MaxClickDate] [datetime] NULL,
[BounceCount] [int] NULL,
[MinBounceDate] [datetime] NULL,
[MaxBounceDate] [datetime] NULL
)
GO
CREATE NONCLUSTERED INDEX [IDX_VR_EmailCampaign_Activity] ON [etl].[VerticalResponse_EmailCampaign_Activity] ([SSB_CRMSYSTEM_CONTACT_ID], [CampaignID])
GO
