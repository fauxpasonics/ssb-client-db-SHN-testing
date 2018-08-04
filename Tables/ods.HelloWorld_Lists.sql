CREATE TABLE [ods].[HelloWorld_Lists]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____40F9A68C] DEFAULT (getdate()),
[ETL__UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____41EDCAC5] DEFAULT (getdate()),
[ETL__IsDeleted] [bit] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____42E1EEFE] DEFAULT ((0)),
[ETL__DeletedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[listid] [int] NOT NULL,
[listname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[HelloWorld_Lists] ADD CONSTRAINT [PK__HelloWor__C4EA2445A9302163] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
