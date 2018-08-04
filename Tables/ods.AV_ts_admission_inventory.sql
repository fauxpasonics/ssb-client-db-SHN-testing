CREATE TABLE [ods].[AV_ts_admission_inventory]
(
[admissioninventory_admission_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admissioninventory_reservation_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admissioninventory_reservation_timeout] [datetime] NULL,
[admissioninventory_on_offer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admissioninventory_on_offer_timeout] [datetime] NULL,
[admissioninventory_order_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admissioninventory_performance_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admissioninventory_price_type_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_CreatedDate] [datetime] NULL
)
GO
