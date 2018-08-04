CREATE TABLE [stg].[HelloWorld_ActiveKeywords]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____4D5F7D71] DEFAULT (getdate()),
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[keyword] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[listid] [int] NOT NULL,
[shortcode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[auto_reply] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[HelloWorld_ActiveKeywords] ADD CONSTRAINT [PK__HelloWor__C4EA2445328DB356] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
