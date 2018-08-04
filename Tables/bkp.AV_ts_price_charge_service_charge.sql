CREATE TABLE [bkp].[AV_ts_price_charge_service_charge]
(
[audit_datetime] [datetime] NULL,
[pricechargeservicecharge_record_state] [int] NOT NULL,
[pricechargeservicecharge_audit_id] [uniqueidentifier] NULL,
[pricechargeservicecharge_create_audit_id] [uniqueidentifier] NULL,
[pricechargeservicecharge_pricecharge_id] [uniqueidentifier] NOT NULL,
[pricechargeservicecharge_service_charge_id] [uniqueidentifier] NOT NULL,
[pricechargeservicecharge_version] [int] NOT NULL,
[pricechargeservicecharge_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
