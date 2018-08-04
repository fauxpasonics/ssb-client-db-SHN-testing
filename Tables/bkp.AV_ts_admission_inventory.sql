CREATE TABLE [bkp].[AV_ts_admission_inventory]
(
[audit_datetime] [datetime] NULL,
[admissioninventory_admission_id] [uniqueidentifier] NOT NULL,
[admissioninventory_reservation_id] [uniqueidentifier] NULL,
[admissioninventory_reservation_timeout] [datetime] NULL,
[admissioninventory_on_offer_id] [uniqueidentifier] NULL,
[admissioninventory_on_offer_timeout] [datetime] NULL,
[admissioninventory_order_id] [uniqueidentifier] NULL,
[admissioninventory_performance_id] [uniqueidentifier] NOT NULL,
[admissioninventory_price_type_id] [uniqueidentifier] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
