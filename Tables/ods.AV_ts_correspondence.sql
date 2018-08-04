CREATE TABLE [ods].[AV_ts_correspondence]
(
[correspondence_record_state] [int] NOT NULL,
[correspondence_audit_id] [uniqueidentifier] NOT NULL,
[correspondence_code] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_create_audit_id] [uniqueidentifier] NULL,
[correspondence_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_document] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_id] [uniqueidentifier] NOT NULL,
[correspondence_search_id] [uniqueidentifier] NULL,
[correspondence_solicitation_amount] [bigint] NULL,
[correspondence_solicitation_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_response_due_date] [datetime] NULL,
[correspondence_owner] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_additional_info] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correspondence_version] [int] NOT NULL,
[correspondence_message_id] [uniqueidentifier] NULL,
[correspondence_appeal_id] [uniqueidentifier] NULL,
[correspondence_sent_date] [datetime] NULL,
[correspondence_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSCreatedDate] [datetime] NULL,
[SSUpdatedDate] [datetime] NULL
)
GO
