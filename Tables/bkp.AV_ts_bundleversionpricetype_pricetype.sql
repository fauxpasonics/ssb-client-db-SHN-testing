CREATE TABLE [bkp].[AV_ts_bundleversionpricetype_pricetype]
(
[audit_datetime] [datetime] NULL,
[bundleversionpricetypepricetype_record_state] [int] NOT NULL,
[bundleversionpricetypepricetype_bundleversionpricetype_id] [uniqueidentifier] NOT NULL,
[bundleversionpricetypepricetype_price_type_id] [uniqueidentifier] NOT NULL,
[bundleversionpricetypepricetype_audit_id] [uniqueidentifier] NULL,
[bundleversionpricetypepricetype_create_audit_id] [uniqueidentifier] NULL,
[bundleversionpricetypepricetype_version] [int] NULL,
[bundleversionpricetypepricetype_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
