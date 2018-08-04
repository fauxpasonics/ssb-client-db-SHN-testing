SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [segmentation].[vw__Custom_Fields]
AS

SELECT *, GETDATE() AS UpdatedDate
FROM dbo.Contact_CustomFields


GO
