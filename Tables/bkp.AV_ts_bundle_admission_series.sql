CREATE TABLE [bkp].[AV_ts_bundle_admission_series]
(
[audit_datetime] [datetime] NULL,
[bundleadmseries_record_state] [int] NOT NULL,
[bundleadmseries_audit_id] [uniqueidentifier] NOT NULL,
[bundleadmseries_bundle_admission_id] [uniqueidentifier] NOT NULL,
[bundleadmseries_create_audit_id] [uniqueidentifier] NULL,
[bundleadmseries_series_id] [uniqueidentifier] NOT NULL,
[bundleadmseries_version] [int] NULL,
[bundleadmseries_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
