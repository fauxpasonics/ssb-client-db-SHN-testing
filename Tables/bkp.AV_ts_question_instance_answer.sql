CREATE TABLE [bkp].[AV_ts_question_instance_answer]
(
[audit_datetime] [datetime] NULL,
[questioninstanceanswer_record_state] [int] NOT NULL,
[questioninstanceanswer_audit_id] [uniqueidentifier] NULL,
[questioninstanceanswer_create_audit_id] [uniqueidentifier] NULL,
[questioninstanceanswer_answer] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[questioninstanceanswer_question_instance_id] [uniqueidentifier] NOT NULL,
[questioninstanceanswer_version] [int] NULL,
[questioninstanceanswer_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
