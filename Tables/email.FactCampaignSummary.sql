CREATE TABLE [email].[FactCampaignSummary]
(
[FactCampaignSummaryId] [int] NOT NULL IDENTITY(-2, 1),
[DimCampaignId] [int] NULL,
[DimCampaignActivityTypeId] [int] NULL,
[ActivityTypeTotal] [int] NULL,
[ActivityTypeUnique] [int] NULL,
[ActivityTypeMinDate] [datetime] NULL,
[ActivityTypeMaxDate] [datetime] NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Creat__60613BFF] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Creat__61556038] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Updat__62498471] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Updat__633DA8AA] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[FactCampaignSummary] ADD CONSTRAINT [PK__FactCamp__7D08EBDFD9B9764A] PRIMARY KEY CLUSTERED  ([FactCampaignSummaryId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignSummary_DimCampaignActivityTypeId] ON [email].[FactCampaignSummary] ([DimCampaignActivityTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignSummary_DimCampaignId] ON [email].[FactCampaignSummary] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignSummary] ADD CONSTRAINT [FK__FactCampa__DimCa__6525F11C] FOREIGN KEY ([DimCampaignId]) REFERENCES [email].[DimCampaign] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignSummary] ADD CONSTRAINT [FK__FactCampa__DimCa__661A1555] FOREIGN KEY ([DimCampaignActivityTypeId]) REFERENCES [email].[DimCampaignActivityType] ([DimCampaignActivityTypeId])
GO
