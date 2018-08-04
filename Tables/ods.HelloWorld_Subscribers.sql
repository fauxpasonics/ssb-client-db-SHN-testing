CREATE TABLE [ods].[HelloWorld_Subscribers]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____58D1301D] DEFAULT (getdate()),
[ETL__UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____59C55456] DEFAULT (getdate()),
[ETL__IsDeleted] [bit] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____5AB9788F] DEFAULT ((0)),
[ETL__DeletedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subscriberid] [int] NOT NULL,
[listid] [int] NOT NULL,
[phone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[keyword] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[signupshortcode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[carrier_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[signupstamp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[HelloWorld_Subscribers] ADD CONSTRAINT [PK__HelloWor__C4EA2445E5BC74AE] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
