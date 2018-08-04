CREATE TABLE [bkp].[AV_ts_miscellaneous_item_keyword]
(
[audit_datetime] [datetime] NULL,
[miscellaneousitemkeyword_record_state] [int] NOT NULL,
[miscellaneousitemkeyword_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemkeyword_create_audit_id] [uniqueidentifier] NULL,
[miscellaneousitemkeyword_miscellaneous_item_id] [uniqueidentifier] NOT NULL,
[miscellaneousitemkeyword_keyword] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[miscellaneousitemkeyword_version] [int] NOT NULL,
[miscellaneousitemkeyword_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
