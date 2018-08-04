CREATE TABLE [dbo].[VerticalResponse_EmailCampaign_Recipients]
(
[ETL__ID] [bigint] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__Source] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[List_Name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Response_Type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Response_Date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Click_Text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Click_URL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_address] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[create_date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[company_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_1] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_2] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[state] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[postalcode] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[work_phone] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[home_phone] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mobile_phone] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fax] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marital_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gender] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[VerticalResponse_EmailCampaign_Recipients] ADD CONSTRAINT [PK__Vertical__C4EA2445279A26F7] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
