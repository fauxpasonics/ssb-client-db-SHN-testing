CREATE TABLE [ods].[HelloWorld_Datafields]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____51300E55] DEFAULT (getdate()),
[ETL__UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____5224328E] DEFAULT (getdate()),
[ETL__IsDeleted] [bit] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____531856C7] DEFAULT ((0)),
[ETL__DeletedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[datafieldid] [int] NOT NULL,
[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[HelloWorld_Datafields] ADD CONSTRAINT [PK__HelloWor__C4EA2445F9A38364] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
