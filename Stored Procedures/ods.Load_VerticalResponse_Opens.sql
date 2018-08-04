SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[Load_VerticalResponse_Opens]
AS 
BEGIN
IF OBJECT_ID('TempDB..#opens') IS NOT NULL 
DROP TABLE #opens

SELECT a.CampaignID, a.List_Name, a.Response_Type, a.Response_Date, a.Email_Address
INTO #opens
FROM ods.vw_VerticalResponse_Opens a --all opens, includes new
LEFT JOIN ods.VerticalResponse_Opens b --materialized opens
    ON a.CampaignID = b.CampaignID
    AND a.Email_Address = b.EmailAddress
    AND a.List_Name = b.List_Name
    AND a.Response_Date = b.Response_Date
WHERE b.ID IS NULL -- filters to only include new opens not yet in the table


INSERT INTO ods.VerticalResponse_Opens (CampaignID, List_Name, Response_Type, Response_Date, EmailAddress, ETL__CreatedDate, ETL__UpdatedDate)
SELECT CampaignID, List_Name, Response_Type, Response_Date, Email_Address, GETDATE(), GETDATE()
FROM #opens
	
END

GO
