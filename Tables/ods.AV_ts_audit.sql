CREATE TABLE [ods].[AV_ts_audit]
(
[action] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[application] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[audit_id] [uniqueidentifier] NOT NULL,
[audit_time] [datetime] NOT NULL,
[business_object] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[business_object_id] [uniqueidentifier] NULL,
[client_address] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[context] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[override_uuid] [uniqueidentifier] NULL,
[result] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sequence] [bigint] NOT NULL,
[server_address] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[transaction_id] [uniqueidentifier] NOT NULL,
[session_id] [uniqueidentifier] NULL,
[user_role_id] [uniqueidentifier] NULL,
[uuid] [uniqueidentifier] NOT NULL,
[batch_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[audit_correspondencedetail_id] [uniqueidentifier] NULL,
[audit_referrer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[audit_create_time] [datetime] NULL,
[audit_correspondencedetail_linkName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SYNC__IsDeleted] [bit] NULL,
[SYNC__CreatedDate] [datetime] NULL,
[SYNC__UpdatedDate] [datetime] NULL,
[SYNC__DeltaHashKey] [binary] (32) NULL
)
GO
CREATE NONCLUSTERED INDEX [IX_Key] ON [ods].[AV_ts_audit] ([audit_id], [sequence])
GO
CREATE NONCLUSTERED INDEX [IX_audit_time] ON [ods].[AV_ts_audit] ([audit_time])
GO
