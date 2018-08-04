CREATE TABLE [ods].[HelloWorld_Keyword]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Keyword] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ListID] [int] NULL,
[ShortCode] [int] NULL,
[Country] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[HelloWorld_Keyword] ADD CONSTRAINT [PK__HelloWor__C4EA24453D4088D2] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
