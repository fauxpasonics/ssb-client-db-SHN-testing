CREATE TABLE [ods].[AV_ts_contact]
(
[contact_record_state] [int] NOT NULL,
[contact_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_birth_date] [datetime] NULL,
[contact_company] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_default_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_email] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_first_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_gender] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_greeting_name] [nvarchar] (242) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_salutation_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_job_title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_language] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_last_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_maiden_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_marital_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_middle_initial] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_parent_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_parent_table] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_e_address1] [nvarchar] (254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_e_address2] [nvarchar] (254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_e_address3] [nvarchar] (254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_number1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_number2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_number3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_number4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_number5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_number6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_phone_search1] [bigint] NULL,
[contact_phone_search2] [bigint] NULL,
[contact_phone_search3] [bigint] NULL,
[contact_phone_search4] [bigint] NULL,
[contact_phone_search5] [bigint] NULL,
[contact_phone_search6] [bigint] NULL,
[contact_publish_name] [nvarchar] (242) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_suffix] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_title] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_type] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contact_version] [int] NOT NULL,
[contact_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
