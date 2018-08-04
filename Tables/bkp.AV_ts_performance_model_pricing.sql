CREATE TABLE [bkp].[AV_ts_performance_model_pricing]
(
[audit_datetime] [datetime] NULL,
[performancemodelpricing_id] [uniqueidentifier] NOT NULL,
[performancemodelpricing_performance_id] [uniqueidentifier] NOT NULL,
[performancemodelpricing_price_zone_id] [uniqueidentifier] NOT NULL,
[performancemodelpricing_rate_type] [tinyint] NOT NULL,
[performancemodelpricing_rate_amount] [bigint] NOT NULL,
[performancemodelpricing_rate_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[performancemodelpricing_record_state] [int] NOT NULL,
[performancemodelpricing_audit_id] [uniqueidentifier] NULL,
[performancemodelpricing_create_audit_id] [uniqueidentifier] NULL,
[performancemodelpricing_version] [int] NULL,
[performancemodelpricing_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
