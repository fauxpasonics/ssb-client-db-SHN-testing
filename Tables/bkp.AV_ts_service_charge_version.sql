CREATE TABLE [bkp].[AV_ts_service_charge_version]
(
[audit_datetime] [datetime] NULL,
[serchargever_record_state] [int] NOT NULL,
[serchargever_audit_id] [uniqueidentifier] NULL,
[serchargever_create_audit_id] [uniqueidentifier] NULL,
[serchargever_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[serchargever_end_date] [datetime] NULL,
[serchargever_id] [uniqueidentifier] NOT NULL,
[serchargever_service_charge_id] [uniqueidentifier] NOT NULL,
[serchargever_start_date] [datetime] NULL,
[serchargever_version] [int] NULL,
[serchargever_level] [int] NULL,
[serchargever_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
