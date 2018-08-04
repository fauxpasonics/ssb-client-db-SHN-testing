CREATE TABLE [ods].[HelloWorld_KeywordActivity]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____6166761E] DEFAULT (getdate()),
[ETL__UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____625A9A57] DEFAULT (getdate()),
[ETL__IsDeleted] [bit] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____634EBE90] DEFAULT ((0)),
[ETL__DeletedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[shortcode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[keyword] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[listid] [int] NOT NULL,
[subscriberid] [int] NOT NULL,
[phone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stamp] [datetime] NOT NULL,
[country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[HelloWorld_KeywordActivity] ADD CONSTRAINT [PK__HelloWor__C4EA244532B4A12C] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
