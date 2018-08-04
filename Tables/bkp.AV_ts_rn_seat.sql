CREATE TABLE [bkp].[AV_ts_rn_seat]
(
[audit_datetime] [datetime] NULL,
[rnseat_record_state] [int] NOT NULL,
[rnseat_audit_id] [uniqueidentifier] NULL,
[rnseat_create_audit_id] [uniqueidentifier] NULL,
[rnseat_description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rnseat_id] [uniqueidentifier] NOT NULL,
[rnseat_order_bundle_id] [uniqueidentifier] NOT NULL,
[rnseat_order_id] [uniqueidentifier] NOT NULL,
[rnseat_performance_id] [uniqueidentifier] NOT NULL,
[rnseat_price_type_id] [uniqueidentifier] NOT NULL,
[rnseat_seat_id] [uniqueidentifier] NOT NULL,
[rnseat_venue_id] [uniqueidentifier] NOT NULL,
[rnseat_version] [int] NULL,
[rnseat_association] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
