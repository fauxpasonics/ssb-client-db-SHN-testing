CREATE TABLE [ods].[VerticalResponse_EmailCampaign_Recipients]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__Source] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[List_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response_Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response_Date] [datetime] NULL,
[Click_Text] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Click_URL] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email_Address] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [ods].[VerticalResponse_EmailCampaign_Recipients] ADD CONSTRAINT [PK_ods__VerticalResponse_CampaignRecipients] PRIMARY KEY NONCLUSTERED  ([ETL__ID])
GO
CREATE CLUSTERED COLUMNSTORE INDEX [CCI_ods__VerticalResponse_EmailCampaign_Recipients] ON [ods].[VerticalResponse_EmailCampaign_Recipients]
GO
CREATE NONCLUSTERED INDEX [IX_ETL__UpdatedDate] ON [ods].[VerticalResponse_EmailCampaign_Recipients] ([ETL__UpdatedDate] DESC)
GO
CREATE NONCLUSTERED INDEX [IX_Key] ON [ods].[VerticalResponse_EmailCampaign_Recipients] ([Response_Date] DESC, [Email_Address], [Response_Type], [List_Name]) INCLUDE ([ETL__DeltaHashKey])
GO
