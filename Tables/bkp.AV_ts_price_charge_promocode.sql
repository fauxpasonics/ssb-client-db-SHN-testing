CREATE TABLE [bkp].[AV_ts_price_charge_promocode]
(
[audit_datetime] [datetime] NULL,
[pricechargepromocode_record_state] [int] NOT NULL,
[pricechargepromocode_audit_id] [uniqueidentifier] NULL,
[pricechargepromocode_create_audit_id] [uniqueidentifier] NULL,
[pricechargepromocode_pricecharge_id] [uniqueidentifier] NOT NULL,
[pricechargepromocode_promocode_id] [uniqueidentifier] NOT NULL,
[pricechargepromocode_version] [int] NOT NULL,
[pricechargepromocode_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
