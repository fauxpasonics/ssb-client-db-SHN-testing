CREATE TABLE [bkp].[AV_ts_bundleversion_pricetype]
(
[audit_datetime] [datetime] NULL,
[bundleversion_pricetype_record_state] [int] NOT NULL,
[bundleversion_pricetype_id] [uniqueidentifier] NOT NULL,
[bundleversion_pricetype_bundleversion_id] [uniqueidentifier] NOT NULL,
[bundleversion_pricetype_min_admissions] [int] NULL,
[bundleversion_pricetype_max_admissions] [int] NULL,
[bundleversion_pricetype_audit_id] [uniqueidentifier] NULL,
[bundleversion_pricetype_create_audit_id] [uniqueidentifier] NULL,
[bundleversion_pricetype_version] [int] NULL,
[bundleversion_pricetype_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
