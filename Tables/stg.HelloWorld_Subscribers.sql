CREATE TABLE [stg].[HelloWorld_Subscribers]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____5D95E53A] DEFAULT (getdate()),
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subscriberid] [int] NOT NULL,
[listid] [int] NOT NULL,
[phone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[keyword] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[signupshortcode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[carrier_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[signupstamp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [stg].[HelloWorld_Subscribers] ADD CONSTRAINT [PK__HelloWor__C4EA24452A912C5B] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
