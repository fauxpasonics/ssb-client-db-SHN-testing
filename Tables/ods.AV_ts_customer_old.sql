CREATE TABLE [ods].[AV_ts_customer_old]
(
[customer_record_state] [int] NOT NULL,
[customer_active_date] [datetime] NULL,
[customer_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_class] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_defualt_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_default_contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_keeper_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_duplicate_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_language] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_state_change_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_number] [bigint] NOT NULL,
[customer_organization_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_organization_type] [int] NULL,
[customer_owner] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_phone_number1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_phone_number2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_phone_number3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_phone_search1] [bigint] NULL,
[customer_phone_search2] [bigint] NULL,
[customer_phone_search3] [bigint] NULL,
[customer_phone_type1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_phone_type2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_phone_type3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_price_type_id] [uniqueidentifier] NULL,
[customer_reference_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_state] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_type] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_version] [int] NOT NULL,
[customer_communication_preferences] [int] NULL,
[customer_marketing_preferences] [int] NULL,
[customer_value] [bigint] NULL,
[customer_rank] [int] NULL,
[customer_total] [int] NULL,
[customer_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_assigned_association] [bigint] NULL,
[customer_message_source] [bigint] NULL,
[customer_integer1] [int] NULL,
[customer_integer2] [int] NULL,
[customer_integer3] [int] NULL,
[customer_integer4] [int] NULL,
[customer_integer5] [int] NULL,
[customer_integer6] [int] NULL,
[customer_bigInteger1] [bigint] NULL,
[customer_bigInteger2] [bigint] NULL,
[customer_bigInteger3] [bigint] NULL,
[customer_bigInteger4] [bigint] NULL,
[customer_bigInteger5] [bigint] NULL,
[customer_bigInteger6] [bigint] NULL,
[customer_fixed1] [bigint] NULL,
[customer_fixed2] [bigint] NULL,
[customer_fixed3] [bigint] NULL,
[customer_fixed4] [bigint] NULL,
[customer_fixed5] [bigint] NULL,
[customer_fixed6] [bigint] NULL,
[customer_reference_code2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer_reference_code3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
