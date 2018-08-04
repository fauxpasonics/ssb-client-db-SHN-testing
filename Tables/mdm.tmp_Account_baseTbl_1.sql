CREATE TABLE [mdm].[tmp_Account_baseTbl_1]
(
[dimcustomerid] [int] NOT NULL,
[ssid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[sourcesystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[hashplaintext_6] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hash_6] [varbinary] (32) NULL
)
GO
CREATE CLUSTERED INDEX [ix_dimcustomerid] ON [mdm].[tmp_Account_baseTbl_1] ([dimcustomerid])
GO
CREATE NONCLUSTERED INDEX [ix_hash_6] ON [mdm].[tmp_Account_baseTbl_1] ([hash_6]) INCLUDE ([dimcustomerid])
GO
