CREATE TABLE [bkp].[AV_ts_benefit_promo_code]
(
[audit_datetime] [datetime] NULL,
[benefitpromocode_record_state] [int] NOT NULL,
[benefitpromocode_audit_id] [uniqueidentifier] NULL,
[benefitpromocode_create_audit_id] [uniqueidentifier] NULL,
[benefitpromocode_benefit_id] [uniqueidentifier] NOT NULL,
[benefitpromocode_promocode_id] [uniqueidentifier] NOT NULL,
[benefitpromocode_version] [int] NULL,
[benefitpromocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
