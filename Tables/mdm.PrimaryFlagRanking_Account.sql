CREATE TABLE [mdm].[PrimaryFlagRanking_Account]
(
[dimcustomerid] [int] NOT NULL,
[sourcesystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssb_crmsystem_acct_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_PRIMARY_FLAG] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_PRIMARY_FLAG] [int] NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_PRIMARY_FLAG] [int] NULL,
[Source System Priority] [int] NOT NULL,
[Audience View Purchase] [datetime] NOT NULL,
[Vertical Response Interaction] [datetime] NOT NULL,
[Hello World Interaction] [datetime] NOT NULL,
[Most Recently Updated] [datetime] NULL,
[Most Recently Created] [datetime] NULL,
[ranking] [bigint] NULL,
[SS_ranking] [bigint] NULL
)
GO
CREATE CLUSTERED INDEX [ix_tmpRanking] ON [mdm].[PrimaryFlagRanking_Account] ([dimcustomerid])
GO
