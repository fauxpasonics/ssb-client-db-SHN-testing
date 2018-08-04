CREATE TABLE [bkp].[AV_ts_order_insert_log]
(
[audit_datetime] [datetime] NULL,
[order_id] [uniqueidentifier] NOT NULL,
[order_number] [int] NULL,
[user_id] [uniqueidentifier] NULL,
[customer_id] [uniqueidentifier] NULL,
[userrole_id] [uniqueidentifier] NULL,
[audit_time] [datetime] NULL,
[client_address] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[server_address] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
