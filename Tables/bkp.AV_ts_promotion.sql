CREATE TABLE [bkp].[AV_ts_promotion]
(
[audit_datetime] [datetime] NULL,
[promocode_record_state] [int] NOT NULL,
[promocode_audit_id] [uniqueidentifier] NULL,
[promocode_create_audit_id] [uniqueidentifier] NULL,
[promocode_id] [uniqueidentifier] NOT NULL,
[promocode_promotion_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[promocode_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_start_date] [datetime] NOT NULL,
[promocode_end_date] [datetime] NULL,
[promocode_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_version] [int] NOT NULL,
[promocode_short_description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_access_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_article_id] [uniqueidentifier] NULL,
[promocode_caps_item_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_caps_customer_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
