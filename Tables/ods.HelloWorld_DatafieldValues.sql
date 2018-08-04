CREATE TABLE [ods].[HelloWorld_DatafieldValues]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____690797E6] DEFAULT (getdate()),
[ETL__UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____69FBBC1F] DEFAULT (getdate()),
[ETL__IsDeleted] [bit] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____6AEFE058] DEFAULT ((0)),
[ETL__DeletedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subscriberid] [int] NOT NULL,
[datafieldid] [int] NOT NULL,
[value] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[stamp] [datetime] NOT NULL
)
GO
ALTER TABLE [ods].[HelloWorld_DatafieldValues] ADD CONSTRAINT [PK__HelloWor__C4EA244572EFFB42] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
