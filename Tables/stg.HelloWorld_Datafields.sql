CREATE TABLE [stg].[HelloWorld_Datafields]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____55F4C372] DEFAULT (getdate()),
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[datafieldid] [int] NOT NULL,
[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[HelloWorld_Datafields] ADD CONSTRAINT [PK__HelloWor__C4EA244540003ECB] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
