CREATE TABLE [email].[DimCampaignActivityType]
(
[DimCampaignActivityTypeId] [int] NOT NULL IDENTITY(-2, 1),
[ActivityType] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__DimCampai__Creat__11397D84] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__DimCampai__Creat__122DA1BD] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__DimCampai__Updat__1321C5F6] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__DimCampai__Updat__1415EA2F] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[DimCampaignActivityType] ADD CONSTRAINT [PK__DimCampa__9DB9554EBEDC38B2] PRIMARY KEY CLUSTERED  ([DimCampaignActivityTypeId])
GO
