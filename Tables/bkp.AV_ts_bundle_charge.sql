CREATE TABLE [bkp].[AV_ts_bundle_charge]
(
[audit_datetime] [datetime] NULL,
[bundlecharge_id] [uniqueidentifier] NOT NULL,
[bundlecharge_bundle_id] [uniqueidentifier] NOT NULL,
[bundlecharge_servicecharge_id] [uniqueidentifier] NOT NULL,
[bundlecharge_calculation_type] [int] NOT NULL,
[bundlecharge_start_date] [datetime] NOT NULL,
[bundlecharge_end_date] [datetime] NULL,
[bundlecharge_record_state] [int] NOT NULL,
[bundlecharge_audit_id] [uniqueidentifier] NULL,
[bundlecharge_create_audit_id] [uniqueidentifier] NULL,
[bundlecharge_version] [int] NULL,
[bundlecharge_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
