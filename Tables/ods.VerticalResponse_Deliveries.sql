CREATE TABLE [ods].[VerticalResponse_Deliveries]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CampaignID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[List_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Response_Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Response_Date] [datetime] NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__CreatedDate] [datetime] NULL,
[ETL__UpdatedDate] [datetime] NULL
)
GO
