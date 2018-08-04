SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[Load_VerticalResponse_Clicks]
AS 
BEGIN
IF OBJECT_ID('TempDB..#clicks') IS NOT NULL 
DROP TABLE #clicks

SELECT a.CampaignID, a.List_Name, a.Response_Type, a.Response_Date, a.Email_Address
INTO #clicks
FROM ods.vw_VerticalResponse_Clicks a --all clicks, includes new
LEFT JOIN ods.VerticalResponse_Clicks b --materialized clicks
    ON a.CampaignID = b.CampaignID
    AND a.Email_Address = b.EmailAddress
    AND a.List_Name = b.List_Name
    AND a.Response_Date = b.Response_Date
WHERE b.ID IS NULL -- filters to only include new clicks not yet in the table


INSERT INTO ods.VerticalResponse_Clicks (CampaignID, List_Name, Response_Type, Response_Date, EmailAddress, ETL__CreatedDate, ETL__UpdatedDate)
SELECT CampaignID, List_Name, Response_Type, Response_Date, Email_Address, GETDATE(), GETDATE()
FROM #clicks
	
END
GO
