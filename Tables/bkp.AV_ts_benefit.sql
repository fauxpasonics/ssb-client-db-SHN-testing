CREATE TABLE [bkp].[AV_ts_benefit]
(
[audit_datetime] [datetime] NULL,
[benefit_record_state] [int] NOT NULL,
[benefit_audit_id] [uniqueidentifier] NOT NULL,
[benefit_create_audit_id] [uniqueidentifier] NOT NULL,
[benefit_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data7] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_data8] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_end_date] [datetime] NULL,
[benefit_financial_value] [bigint] NULL,
[benefit_id] [uniqueidentifier] NOT NULL,
[benefit_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[benefit_start_date] [datetime] NULL,
[benefit_valid_until] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_valid_from] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[benefit_version] [int] NOT NULL,
[benefit_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
