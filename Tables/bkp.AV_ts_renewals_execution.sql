CREATE TABLE [bkp].[AV_ts_renewals_execution]
(
[audit_datetime] [datetime] NULL,
[renewalsexecution_record_state] [int] NOT NULL,
[renewalsexecution_audit_id] [uniqueidentifier] NOT NULL,
[renewalsexecution_create_audit_id] [uniqueidentifier] NULL,
[renewalsexecution_id] [uniqueidentifier] NOT NULL,
[renewalsexecution_renewals_id] [uniqueidentifier] NOT NULL,
[renewalsexecution_number_orders] [int] NOT NULL,
[renewalsexecution_number_failed] [int] NOT NULL,
[renewalsexecution_start_time] [datetime] NOT NULL,
[renewalsexecution_end_time] [datetime] NOT NULL,
[renewalsexecution_type] [int] NOT NULL,
[renewalsexecution_version] [int] NOT NULL,
[renewalsexecution_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
