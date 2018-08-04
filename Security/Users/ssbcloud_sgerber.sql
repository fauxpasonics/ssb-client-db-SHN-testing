IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ssbcloud\sgerber')
CREATE LOGIN [ssbcloud\sgerber] FROM WINDOWS
GO
CREATE USER [ssbcloud\sgerber] FOR LOGIN [ssbcloud\sgerber] WITH DEFAULT_SCHEMA=[ssbcloud\sgerber]
GO
REVOKE CONNECT TO [ssbcloud\sgerber]
