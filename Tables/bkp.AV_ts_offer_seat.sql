CREATE TABLE [bkp].[AV_ts_offer_seat]
(
[audit_datetime] [datetime] NULL,
[offer_seat_record_state] [int] NOT NULL,
[offer_seat_audit_id] [uniqueidentifier] NOT NULL,
[offer_seat_create_audit_id] [uniqueidentifier] NULL,
[offer_seat_version] [int] NOT NULL,
[offer_seat_id] [uniqueidentifier] NOT NULL,
[offer_seat_customer_id] [uniqueidentifier] NULL,
[offer_seat_admission_id] [uniqueidentifier] NULL,
[offer_seat_seat_id] [uniqueidentifier] NULL,
[offer_seat_customer_offer_id] [uniqueidentifier] NOT NULL,
[offer_seat_bundle_id] [uniqueidentifier] NULL,
[offer_seat_bundle_instance] [int] NULL,
[offer_seat_price_type_id] [uniqueidentifier] NULL,
[offer_seat_price_value_id] [uniqueidentifier] NULL,
[offer_seat_hold_value_id] [uniqueidentifier] NULL,
[offer_seat_option] [int] NULL,
[offer_seat_performance_id] [uniqueidentifier] NULL,
[offer_seat_promo_code_id] [uniqueidentifier] NULL,
[offer_seat_order_id] [uniqueidentifier] NULL,
[offer_seat_agent_customer_id] [uniqueidentifier] NULL,
[offer_seat_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[offer_seat_access_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
