CREATE TABLE [dbo].[DimPromoCode]
(
[ETL__SSID] [uniqueidentifier] NULL,
[ETL__SSID_AV_promo_code_id] [uniqueidentifier] NULL,
[PromoCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PromoName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PromoDesc] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
