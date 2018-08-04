CREATE TABLE [email].[FactCampaignEmailDetail]
(
[FactCampaignEmailDetailId] [int] NOT NULL IDENTITY(-2, 1),
[DimCampaignId] [int] NULL,
[DimCampaignActivityTypeId] [int] NULL,
[DimEmailId] [int] NULL,
[DimBrowserId] [int] NULL,
[DimOperationSystemId] [int] NULL,
[DimEmailClientId] [int] NULL,
[DimDeviceId] [int] NULL,
[DimCampaignTypeId] [int] NULL,
[DimChannelId] [int] NULL,
[ActivityReason] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IPAddress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActivityDateTime] [datetime] NULL,
[URL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URLAlias] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Src_SendId] [int] NULL,
[Src_ActivityId] [int] NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Creat__41DCB4DF] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Creat__42D0D918] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Updat__43C4FD51] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Updat__44B9218A] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [PK__FactCamp__58B5031108566D15] PRIMARY KEY CLUSTERED  ([FactCampaignEmailDetailId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimBrowserId] ON [email].[FactCampaignEmailDetail] ([DimBrowserId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimCampaignActivityTypeId] ON [email].[FactCampaignEmailDetail] ([DimCampaignActivityTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimCampaignId] ON [email].[FactCampaignEmailDetail] ([DimCampaignId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimCampaignTypeId] ON [email].[FactCampaignEmailDetail] ([DimCampaignTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimChannelId] ON [email].[FactCampaignEmailDetail] ([DimChannelId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimDeviceId] ON [email].[FactCampaignEmailDetail] ([DimDeviceId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimEmailClientId] ON [email].[FactCampaignEmailDetail] ([DimEmailClientId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimEmailId] ON [email].[FactCampaignEmailDetail] ([DimEmailId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimOperationSystemId] ON [email].[FactCampaignEmailDetail] ([DimOperationSystemId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimBr__497DD6A7] FOREIGN KEY ([DimBrowserId]) REFERENCES [email].[DimBrowser] ([DimBrowserId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCa__46A169FC] FOREIGN KEY ([DimCampaignId]) REFERENCES [email].[DimCampaign] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCa__47958E35] FOREIGN KEY ([DimCampaignActivityTypeId]) REFERENCES [email].[DimCampaignActivityType] ([DimCampaignActivityTypeId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCa__4D4E678B] FOREIGN KEY ([DimCampaignTypeId]) REFERENCES [email].[DimCampaignType] ([DimCampaignTypeId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCh__4E428BC4] FOREIGN KEY ([DimChannelId]) REFERENCES [email].[DimChannel] ([DimChannelId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimDe__4C5A4352] FOREIGN KEY ([DimDeviceId]) REFERENCES [email].[DimDevice] ([DimDeviceId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimEm__4889B26E] FOREIGN KEY ([DimEmailId]) REFERENCES [email].[DimEmail] ([DimEmailID])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimEm__4B661F19] FOREIGN KEY ([DimEmailClientId]) REFERENCES [email].[DimEmailClient] ([DimEmailClientId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimOp__4A71FAE0] FOREIGN KEY ([DimOperationSystemId]) REFERENCES [email].[DimOperatingSystem] ([DimOperatingSystemId])
GO
