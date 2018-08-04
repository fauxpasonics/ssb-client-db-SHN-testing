CREATE TABLE [stg].[HelloWorld_Unsubscribes]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__HelloWorl__ETL____3B40CD36] DEFAULT (getdate()),
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subscriberid] [int] NOT NULL,
[listid] [int] NOT NULL,
[phone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[keyword] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[signupshortcode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[carrier_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[signupstamp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[unsubscribe_stamp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[unsubscribe_type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[HelloWorld_Unsubscribes] ADD CONSTRAINT [PK__HelloWor__C4EA24452ADB9F17] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
