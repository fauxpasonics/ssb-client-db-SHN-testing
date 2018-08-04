CREATE TABLE [ods].[AV_ts_ticket_audit]
(
[next_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_record_state] [int] NULL,
[sequence] [bigint] NULL,
[ticket_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_create_audit_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_date_printed] [datetime] NULL,
[ticket_usage_count] [int] NULL,
[ticket_deliverymethod_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_mark_description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_taken_date] [datetime] NULL,
[ticket_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_item_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_barcode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_order_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_parent_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_cancel_reason] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_status] [int] NULL,
[ticket_customer_pass_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_template_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_print_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_zone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gate_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_performance_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_price_type_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_version] [int] NULL,
[timestamp] [datetime] NULL,
[ticket_miscellaneous_item_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_miscellaneous_option_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_seat_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gateaccess1_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gateaccess2_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gateaccess3_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gateaccess4_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gateaccess5_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_gateaccess6_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_zone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_zone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_zone4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_zone5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_zone6] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_customer_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_CreatedDate] [datetime] NULL
)
GO
