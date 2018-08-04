CREATE TABLE [ods].[AV_ts_order_admission_audit]
(
[orderadmission_net] [bigint] NULL,
[orderadmission_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_net_delta] [bigint] NULL,
[orderadmission_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge2_delta] [bigint] NULL,
[orderadmission_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge2_delta] [bigint] NULL,
[orderadmission_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_previous_price_type_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge2] [bigint] NULL,
[orderadmission_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge2] [bigint] NULL,
[orderadmission_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_net_paid] [bigint] NULL,
[orderadmission_net_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_net_paid_delta] [bigint] NULL,
[orderadmission_net_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge2_paid_delta] [bigint] NULL,
[orderadmission_incl_charge2_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge2_paid_delta] [bigint] NULL,
[orderadmission_add_charge2_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge2_paid] [bigint] NULL,
[orderadmission_incl_charge2_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge2_paid] [bigint] NULL,
[orderadmission_add_charge2_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_amount] [bigint] NULL,
[orderadmission_amount_delta] [bigint] NULL,
[orderadmission_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[next_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_admission_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_performance_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_order_bundle_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_bundle_element_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_order_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_price_type_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_version] [int] NULL,
[orderadmission_default_price_type_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_update_delivery_method_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_state] [int] NULL,
[orderadmission_customerpass_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_customer_offer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_price_value_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_hold_value_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_fill_value_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_override_barcode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_override_ticket_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_card_number] [bigint] NULL,
[orderadmission_record_state] [int] NULL,
[sequence] [bigint] NULL,
[timestamp] [datetime] NULL,
[orderadmission_release_reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_print_status] [int] NULL,
[orderadmission_print_count] [int] NULL,
[orderadmission_promo_code_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge1] [bigint] NULL,
[orderadmission_incl_charge1_delta] [bigint] NULL,
[orderadmission_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge1_paid] [bigint] NULL,
[orderadmission_incl_charge1_paid_delta] [bigint] NULL,
[orderadmission_incl_charge1_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge1_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge1] [bigint] NULL,
[orderadmission_add_charge1_delta] [bigint] NULL,
[orderadmission_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge1_paid] [bigint] NULL,
[orderadmission_add_charge1_paid_delta] [bigint] NULL,
[orderadmission_add_charge1_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge1_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge3] [bigint] NULL,
[orderadmission_incl_charge3_delta] [bigint] NULL,
[orderadmission_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge3_paid] [bigint] NULL,
[orderadmission_incl_charge3_paid_delta] [bigint] NULL,
[orderadmission_incl_charge3_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge3_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge3] [bigint] NULL,
[orderadmission_add_charge3_delta] [bigint] NULL,
[orderadmission_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge3_paid] [bigint] NULL,
[orderadmission_add_charge3_paid_delta] [bigint] NULL,
[orderadmission_add_charge3_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge3_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge4] [bigint] NULL,
[orderadmission_incl_charge4_delta] [bigint] NULL,
[orderadmission_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge4_paid] [bigint] NULL,
[orderadmission_incl_charge4_paid_delta] [bigint] NULL,
[orderadmission_incl_charge4_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge4_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge4] [bigint] NULL,
[orderadmission_add_charge4_delta] [bigint] NULL,
[orderadmission_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge4_paid] [bigint] NULL,
[orderadmission_add_charge4_paid_delta] [bigint] NULL,
[orderadmission_add_charge4_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge4_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge5] [bigint] NULL,
[orderadmission_incl_charge5_delta] [bigint] NULL,
[orderadmission_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge5_paid] [bigint] NULL,
[orderadmission_incl_charge5_paid_delta] [bigint] NULL,
[orderadmission_incl_charge5_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_incl_charge5_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge5] [bigint] NULL,
[orderadmission_add_charge5_delta] [bigint] NULL,
[orderadmission_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge5_paid] [bigint] NULL,
[orderadmission_add_charge5_paid_delta] [bigint] NULL,
[orderadmission_add_charge5_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_add_charge5_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_total] [bigint] NULL,
[orderadmission_total_delta] [bigint] NULL,
[orderadmission_total_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_total_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_transaction_state] [int] NULL,
[orderadmission_agent_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_seat_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_default_amount] [bigint] NULL,
[orderadmission_default_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_drawdown] [bigint] NULL,
[orderadmission_drawdown_delta] [bigint] NULL,
[orderadmission_drawdown_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_drawdown_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_pricing_method] [bigint] NULL,
[orderadmission_association] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderadmission_access_code] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_CreatedDate] [datetime] NULL
)
GO
