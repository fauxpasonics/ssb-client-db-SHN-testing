CREATE TABLE [bkp].[AV_ts_payment_method]
(
[audit_datetime] [datetime] NULL,
[paymentmethod_record_state] [int] NOT NULL,
[paymentmethod_audit_id] [uniqueidentifier] NULL,
[paymentmethod_checksum] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_create_audit_id] [uniqueidentifier] NULL,
[paymentmethod_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_gateway] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_id] [uniqueidentifier] NOT NULL,
[paymentmethod_merchant_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[paymentmethod_pattern] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_roles] [uniqueidentifier] NULL,
[paymentmethod_signature_template_id] [uniqueidentifier] NULL,
[paymentmethod_receipt_template_id] [uniqueidentifier] NULL,
[paymentmethod_failure_template_id] [uniqueidentifier] NULL,
[paymentmethod_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_version] [int] NULL,
[paymentmethod_gl_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_gl_description1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_gl_description2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_payer_auth_enabled] [int] NULL,
[paymentmethod_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_detailed_description] [uniqueidentifier] NULL,
[paymentmethod_storage_type] [int] NULL,
[paymentmethod_merchant_failure_template_id] [uniqueidentifier] NULL,
[paymentmethod_icon] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_express_checkout_icon] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_options] [int] NULL,
[paymentmethod_express_checkout_info_icon] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymentmethod_express_checkout_info_action] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO