CREATE TABLE [stg].[HelloWorld_Lists]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____45BE5BA9] DEFAULT (getdate()),
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[listid] [int] NOT NULL,
[listname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[HelloWorld_Lists] ADD CONSTRAINT [PK__HelloWor__C4EA2445C25815B9] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
