CREATE TABLE [ods].[AV_ts_order]
(
[order_record_state] [int] NOT NULL,
[order_incl_charge2] [bigint] NULL,
[order_incl_charge2_delta] [bigint] NULL,
[order_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge2] [bigint] NULL,
[order_add_charge2_delta] [bigint] NULL,
[order_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_charge_net] [bigint] NULL,
[order_charge_net_delta] [bigint] NULL,
[order_charge_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_charge_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_grand_total] [bigint] NULL,
[order_grand_total_delta] [bigint] NULL,
[order_grand_total_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_grand_total_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge2] [bigint] NULL,
[order_total_charge2_delta] [bigint] NULL,
[order_total_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_net] [bigint] NULL,
[order_total_net_delta] [bigint] NULL,
[order_total_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_amount] [bigint] NULL,
[order_total_amount_delta] [bigint] NULL,
[order_total_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_charge_amount] [bigint] NULL,
[order_charge_amount_delta] [bigint] NULL,
[order_charge_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_charge_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_net] [bigint] NULL,
[order_bundle_net_delta] [bigint] NULL,
[order_bundle_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge2] [bigint] NULL,
[order_bundle_incl_charge2_delta] [bigint] NULL,
[order_bundle_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge2] [bigint] NULL,
[order_bundle_add_charge2_delta] [bigint] NULL,
[order_bundle_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_net] [bigint] NULL,
[order_admission_net_delta] [bigint] NULL,
[order_admission_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge2] [bigint] NULL,
[order_admission_incl_charge2_delta] [bigint] NULL,
[order_admission_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge2] [bigint] NULL,
[order_admission_add_charge2_delta] [bigint] NULL,
[order_admission_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_net] [bigint] NULL,
[order_request_net_delta] [bigint] NULL,
[order_request_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge2] [bigint] NULL,
[order_request_incl_charge2_delta] [bigint] NULL,
[order_request_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge2] [bigint] NULL,
[order_request_add_charge2_delta] [bigint] NULL,
[order_request_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_gift_certificate_amount] [bigint] NULL,
[order_total_gift_certificate_amount_delta] [bigint] NULL,
[order_total_gift_certificate_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_gift_certificate_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_gift_amount] [bigint] NULL,
[order_total_gift_amount_delta] [bigint] NULL,
[order_total_gift_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_gift_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_active_date] [datetime] NULL,
[order_legacy_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_secondary_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_count] [int] NULL,
[order_admissions_added] [int] NULL,
[order_admissions_removed] [int] NULL,
[order_allocation_status] [int] NULL,
[order_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_auth_payment_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_auth_payment_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_auth_payment_total] [bigint] NULL,
[order_auth_payment_total_delta] [bigint] NULL,
[order_balance_due_date] [datetime] NULL,
[order_billing_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_secondary_contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_customer_offer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_delivery_charge_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_deliverymethod_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_due] [bigint] NULL,
[order_due_delta] [bigint] NULL,
[order_due_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_due_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_first_performance_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_source_order_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_number] [int] NULL,
[order_payment_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_payment_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_payment_total] [bigint] NULL,
[order_payment_total_delta] [bigint] NULL,
[order_scheduled_payment_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_scheduled_payment_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_scheduled_payment_total] [bigint] NULL,
[order_scheduled_payment_total_delta] [bigint] NULL,
[order_total_allocated_adm] [bigint] NULL,
[order_total_allocated_adm_delta] [bigint] NULL,
[order_total_allocated_adm_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_adm_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_gc] [bigint] NULL,
[order_total_allocated_gc_delta] [bigint] NULL,
[order_total_allocated_gc_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_gc_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_gift] [bigint] NULL,
[order_total_allocated_gift_delta] [bigint] NULL,
[order_total_allocated_gift_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_gift_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_req] [bigint] NULL,
[order_total_allocated_req_delta] [bigint] NULL,
[order_total_allocated_req_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_req_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_sc] [bigint] NULL,
[order_total_allocated_sc_delta] [bigint] NULL,
[order_total_allocated_sc_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_sc_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_version] [int] NOT NULL,
[order_deposit_amount_due] [bigint] NULL,
[order_deposit_amount_due_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_deposit_due_date] [datetime] NULL,
[order_type] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_unpaidreason] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge1] [bigint] NULL,
[order_incl_charge1_delta] [bigint] NULL,
[order_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge1] [bigint] NULL,
[order_add_charge1_delta] [bigint] NULL,
[order_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge1] [bigint] NULL,
[order_bundle_incl_charge1_delta] [bigint] NULL,
[order_bundle_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge1] [bigint] NULL,
[order_bundle_add_charge1_delta] [bigint] NULL,
[order_bundle_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge1] [bigint] NULL,
[order_admission_incl_charge1_delta] [bigint] NULL,
[order_admission_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge1] [bigint] NULL,
[order_admission_add_charge1_delta] [bigint] NULL,
[order_admission_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge1] [bigint] NULL,
[order_request_incl_charge1_delta] [bigint] NULL,
[order_request_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge1] [bigint] NULL,
[order_request_add_charge1_delta] [bigint] NULL,
[order_request_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge1] [bigint] NULL,
[order_total_charge1_delta] [bigint] NULL,
[order_total_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge3] [bigint] NULL,
[order_incl_charge3_delta] [bigint] NULL,
[order_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge3] [bigint] NULL,
[order_add_charge3_delta] [bigint] NULL,
[order_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge3] [bigint] NULL,
[order_bundle_incl_charge3_delta] [bigint] NULL,
[order_bundle_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge3] [bigint] NULL,
[order_bundle_add_charge3_delta] [bigint] NULL,
[order_bundle_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge3] [bigint] NULL,
[order_admission_incl_charge3_delta] [bigint] NULL,
[order_admission_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge3] [bigint] NULL,
[order_admission_add_charge3_delta] [bigint] NULL,
[order_admission_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge3] [bigint] NULL,
[order_request_incl_charge3_delta] [bigint] NULL,
[order_request_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge3] [bigint] NULL,
[order_request_add_charge3_delta] [bigint] NULL,
[order_request_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge3] [bigint] NULL,
[order_total_charge3_delta] [bigint] NULL,
[order_total_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge4] [bigint] NULL,
[order_incl_charge4_delta] [bigint] NULL,
[order_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge4] [bigint] NULL,
[order_add_charge4_delta] [bigint] NULL,
[order_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge4] [bigint] NULL,
[order_bundle_incl_charge4_delta] [bigint] NULL,
[order_bundle_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge4] [bigint] NULL,
[order_bundle_add_charge4_delta] [bigint] NULL,
[order_bundle_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge4] [bigint] NULL,
[order_admission_incl_charge4_delta] [bigint] NULL,
[order_admission_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge4] [bigint] NULL,
[order_admission_add_charge4_delta] [bigint] NULL,
[order_admission_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge4] [bigint] NULL,
[order_request_incl_charge4_delta] [bigint] NULL,
[order_request_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge4] [bigint] NULL,
[order_request_add_charge4_delta] [bigint] NULL,
[order_request_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge4] [bigint] NULL,
[order_total_charge4_delta] [bigint] NULL,
[order_total_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge5] [bigint] NULL,
[order_incl_charge5_delta] [bigint] NULL,
[order_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge5] [bigint] NULL,
[order_add_charge5_delta] [bigint] NULL,
[order_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge5] [bigint] NULL,
[order_bundle_incl_charge5_delta] [bigint] NULL,
[order_bundle_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge5] [bigint] NULL,
[order_bundle_add_charge5_delta] [bigint] NULL,
[order_bundle_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_bundle_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge5] [bigint] NULL,
[order_admission_incl_charge5_delta] [bigint] NULL,
[order_admission_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge5] [bigint] NULL,
[order_admission_add_charge5_delta] [bigint] NULL,
[order_admission_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_admission_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge5] [bigint] NULL,
[order_request_incl_charge5_delta] [bigint] NULL,
[order_request_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge5] [bigint] NULL,
[order_request_add_charge5_delta] [bigint] NULL,
[order_request_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge5] [bigint] NULL,
[order_total_charge5_delta] [bigint] NULL,
[order_total_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge] [bigint] NULL,
[order_total_charge_delta] [bigint] NULL,
[order_total_charge_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_charge_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_invoice_date] [datetime] NULL,
[order_invoice_number] [int] NULL,
[order_item_net] [bigint] NULL,
[order_item_net_delta] [bigint] NULL,
[order_item_net_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_net_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge1] [bigint] NULL,
[order_item_incl_charge1_delta] [bigint] NULL,
[order_item_incl_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge2] [bigint] NULL,
[order_item_incl_charge2_delta] [bigint] NULL,
[order_item_incl_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge3] [bigint] NULL,
[order_item_incl_charge3_delta] [bigint] NULL,
[order_item_incl_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge4] [bigint] NULL,
[order_item_incl_charge4_delta] [bigint] NULL,
[order_item_incl_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge5] [bigint] NULL,
[order_item_incl_charge5_delta] [bigint] NULL,
[order_item_incl_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_incl_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge1] [bigint] NULL,
[order_item_add_charge1_delta] [bigint] NULL,
[order_item_add_charge1_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge1_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge2] [bigint] NULL,
[order_item_add_charge2_delta] [bigint] NULL,
[order_item_add_charge2_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge2_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge3] [bigint] NULL,
[order_item_add_charge3_delta] [bigint] NULL,
[order_item_add_charge3_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge3_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge4] [bigint] NULL,
[order_item_add_charge4_delta] [bigint] NULL,
[order_item_add_charge4_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge4_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge5] [bigint] NULL,
[order_item_add_charge5_delta] [bigint] NULL,
[order_item_add_charge5_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_add_charge5_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_amount] [bigint] NULL,
[order_item_amount_delta] [bigint] NULL,
[order_item_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_item_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_miscItems] [bigint] NULL,
[order_total_allocated_miscItems_delta] [bigint] NULL,
[order_total_allocated_miscItems_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_total_allocated_miscItems_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_total_amount] [bigint] NULL,
[order_request_total_amount_delta] [bigint] NULL,
[order_request_total_amount_currency] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_request_total_amount_currency_delta] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_agent_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_agent_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_agent_contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_shipping_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orders_shipping_address_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_shipping_contact_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_assigned_association] [bigint] NULL,
[order_renewablepayment_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
