CREATE TABLE [ods].[DimArena]
(
[ETL__SSID] [uniqueidentifier] NULL,
[ETL__SSID_AV_venue_ID] [uniqueidentifier] NULL,
[ArenaName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ArenaDescription] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL,
[AV_venue_group] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
