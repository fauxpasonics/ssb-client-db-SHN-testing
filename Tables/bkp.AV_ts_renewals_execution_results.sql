CREATE TABLE [bkp].[AV_ts_renewals_execution_results]
(
[audit_datetime] [datetime] NULL,
[renewalsexecutionresults_record_state] [int] NOT NULL,
[renewalsexecutionresults_audit_id] [uniqueidentifier] NOT NULL,
[renewalsexecutionresults_create_audit_id] [uniqueidentifier] NULL,
[renewalsexecutionresults_id] [uniqueidentifier] NOT NULL,
[renewalsexecutionresults_renewalsexecution_id] [uniqueidentifier] NOT NULL,
[renewalsexecutionresults_src_order_id] [uniqueidentifier] NOT NULL,
[renewalsexecutionresults_dest_offer_id] [uniqueidentifier] NULL,
[renewalsexecutionresults_dest_order_id] [uniqueidentifier] NULL,
[renewalsexecutionresults_message] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renewalsexecutionresults_status] [int] NOT NULL,
[renewalsexecutionresults_version] [int] NOT NULL,
[renewalsexecutionresults_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
