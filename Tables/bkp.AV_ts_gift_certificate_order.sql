CREATE TABLE [bkp].[AV_ts_gift_certificate_order]
(
[audit_datetime] [datetime] NULL,
[giftcertificateorder_record_state] [int] NOT NULL,
[giftcertificateorder_audit_id] [uniqueidentifier] NULL,
[giftcertificateorder_create_audit_id] [uniqueidentifier] NULL,
[giftcertificateorder_gift_certificate_id] [uniqueidentifier] NOT NULL,
[giftcertificateorder_order_id] [uniqueidentifier] NOT NULL,
[giftcertificateorder_version] [int] NULL,
[giftcertificateorder_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
