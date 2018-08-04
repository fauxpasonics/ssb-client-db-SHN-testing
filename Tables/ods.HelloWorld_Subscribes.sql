CREATE TABLE [ods].[HelloWorld_Subscribes]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubscribeID] [int] NULL,
[ListID] [int] NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Keyword] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShortCode] [int] NULL,
[CarrierName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SignUpStamp] [datetime] NULL
)
GO
ALTER TABLE [ods].[HelloWorld_Subscribes] ADD CONSTRAINT [PK__HelloWor__C4EA2445DA56614C] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
