CREATE TABLE [ods].[VerticalResponse_Clicks]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CampaignID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[List_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Response_Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Response_Date] [datetime] NULL,
[Click_Text] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Click_URL] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__CreatedDate] [datetime] NULL,
[ETL__UpdatedDate] [datetime] NULL
)
GO
