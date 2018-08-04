CREATE TABLE [apietl].[VerticalResponse_CampaignRecipients_FileNames]
(
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SourceFileName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__DestinationFileName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ID] [int] NOT NULL
)
GO
