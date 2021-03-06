CREATE TABLE [ods].[AV_ts_order_item]
(
[orderitem_record_state] [int] NOT NULL,
[orderitem_net] [bigint] NULL,
[orderitem_net_delta] [bigint] NULL,
[orderitem_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_net_paid] [bigint] NULL,
[orderitem_net_paid_delta] [bigint] NULL,
[orderitem_net_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_net_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge1] [bigint] NULL,
[orderitem_incl_charge1_delta] [bigint] NULL,
[orderitem_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge1_paid] [bigint] NULL,
[orderitem_incl_charge1_paid_delta] [bigint] NULL,
[orderitem_incl_charge1_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge1_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge2] [bigint] NULL,
[orderitem_incl_charge2_delta] [bigint] NULL,
[orderitem_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge2_paid] [bigint] NULL,
[orderitem_incl_charge2_paid_delta] [bigint] NULL,
[orderitem_incl_charge2_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge2_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge3] [bigint] NULL,
[orderitem_incl_charge3_delta] [bigint] NULL,
[orderitem_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge3_paid] [bigint] NULL,
[orderitem_incl_charge3_paid_delta] [bigint] NULL,
[orderitem_incl_charge3_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge3_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge4] [bigint] NULL,
[orderitem_incl_charge4_delta] [bigint] NULL,
[orderitem_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge4_paid] [bigint] NULL,
[orderitem_incl_charge4_paid_delta] [bigint] NULL,
[orderitem_incl_charge4_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge4_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge5] [bigint] NULL,
[orderitem_incl_charge5_delta] [bigint] NULL,
[orderitem_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge5_paid] [bigint] NULL,
[orderitem_incl_charge5_paid_delta] [bigint] NULL,
[orderitem_incl_charge5_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_incl_charge5_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge1] [bigint] NULL,
[orderitem_add_charge1_delta] [bigint] NULL,
[orderitem_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge1_paid] [bigint] NULL,
[orderitem_add_charge1_paid_delta] [bigint] NULL,
[orderitem_add_charge1_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge1_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge2] [bigint] NULL,
[orderitem_add_charge2_delta] [bigint] NULL,
[orderitem_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge2_paid] [bigint] NULL,
[orderitem_add_charge2_paid_delta] [bigint] NULL,
[orderitem_add_charge2_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge2_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge3] [bigint] NULL,
[orderitem_add_charge3_delta] [bigint] NULL,
[orderitem_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge3_paid] [bigint] NULL,
[orderitem_add_charge3_paid_delta] [bigint] NULL,
[orderitem_add_charge3_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge3_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge4] [bigint] NULL,
[orderitem_add_charge4_delta] [bigint] NULL,
[orderitem_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge4_paid] [bigint] NULL,
[orderitem_add_charge4_paid_delta] [bigint] NULL,
[orderitem_add_charge4_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge4_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge5] [bigint] NULL,
[orderitem_add_charge5_delta] [bigint] NULL,
[orderitem_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge5_paid] [bigint] NULL,
[orderitem_add_charge5_paid_delta] [bigint] NULL,
[orderitem_add_charge5_paid_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_add_charge5_paid_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_total] [bigint] NULL,
[orderitem_total_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_amount] [bigint] NULL,
[orderitem_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_customerpass_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_assigned_customerpass_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_comment] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_override_ticket_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_ticket_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_bundle_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_record_number] [int] NULL,
[orderitem_print_status] [int] NOT NULL,
[orderitem_print_count] [int] NULL,
[orderitem_order_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_rate_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_version] [int] NOT NULL,
[orderitem_miscellaneous_item_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_data1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_data2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_data3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_option_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_customer_offer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_promo_code_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_transaction_state] [int] NOT NULL,
[orderitem_agent_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_order_bundle_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_bundle_miscitem_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orderitem_access_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
