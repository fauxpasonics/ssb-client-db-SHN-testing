CREATE TABLE [ods].[VerticalResponse_EmailCampaigns_Stats]
(
[CampaignId] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CampaignName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SentDate] [datetime] NULL,
[EmailCreditCostSpecified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LocalEmailCreditCostSpecified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AdditionalCostsSpecified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrencyConversionRateSpecified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ROISpecified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailsSent] [int] NULL,
[OpenCount] [int] NULL,
[ReopenCount] [int] NULL,
[ClickCount] [int] NULL,
[SaleCount] [int] NULL,
[PurchaseTotal] [decimal] (18, 6) NULL,
[BounceCount] [int] NULL,
[UnsubCount] [int] NULL,
[ForwardCount] [int] NULL,
[ForwardCountSpecified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResponderCount] [int] NULL,
[FacebookLikeCount] [int] NULL,
[TwitterShareCount] [int] NULL,
[LinkedinShareCount] [int] NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [ods].[VerticalResponse_EmailCampaigns_Stats] ADD CONSTRAINT [PK__Vertical__3F5E8A992BFF1A93] PRIMARY KEY CLUSTERED  ([CampaignId])
GO
