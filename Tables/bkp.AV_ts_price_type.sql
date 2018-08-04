CREATE TABLE [bkp].[AV_ts_price_type]
(
[audit_datetime] [datetime] NULL,
[price_type_record_state] [int] NOT NULL,
[price_type_audit_id] [uniqueidentifier] NULL,
[price_type_create_audit_id] [uniqueidentifier] NULL,
[price_type_id] [uniqueidentifier] NOT NULL,
[price_type_map_symbol] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[price_type_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_group] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_version] [int] NULL,
[price_type_colour] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_caps_item_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_caps_customer_group] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_type_detailed_description] [uniqueidentifier] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
