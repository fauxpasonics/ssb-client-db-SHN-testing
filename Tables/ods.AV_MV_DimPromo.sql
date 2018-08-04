CREATE TABLE [ods].[AV_MV_DimPromo]
(
[ETL__SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_AV_promo_code_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PromoCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PromoName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PromoDesc] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL
)
GO
