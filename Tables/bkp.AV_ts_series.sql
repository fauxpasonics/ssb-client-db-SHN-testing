CREATE TABLE [bkp].[AV_ts_series]
(
[audit_datetime] [datetime] NULL,
[series_record_state] [int] NOT NULL,
[series_audit_id] [uniqueidentifier] NULL,
[series_options] [int] NULL,
[series_create_audit_id] [uniqueidentifier] NULL,
[series_popupmessage] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data1] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data2] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data3] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data4] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data5] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data6] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data7] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_data8] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_end_date] [datetime] NULL,
[series_group] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_id] [uniqueidentifier] NOT NULL,
[series_merchant_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[series_producer_id] [uniqueidentifier] NULL,
[series_rank] [int] NULL,
[series_start_date] [datetime] NULL,
[series_ticket_template_id] [uniqueidentifier] NULL,
[series_additional_info] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_logo1] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_logo2] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_venue_id] [uniqueidentifier] NOT NULL,
[series_version] [int] NULL,
[series_comment1] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_caps_customer_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[series_addon_article] [uniqueidentifier] NULL,
[series_sales_type] [int] NULL,
[series_upsell_article] [uniqueidentifier] NULL,
[series_delivery_method_gateway] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
