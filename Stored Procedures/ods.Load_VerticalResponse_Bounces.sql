SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[Load_VerticalResponse_Bounces]
AS 
BEGIN
IF OBJECT_ID('TempDB..#tmp') IS NOT NULL 
DROP TABLE #tmp

SELECT a.CampaignID, a.List_Name, a.Response_Type, a.Response_Date, a.Email_Address
INTO #tmp
FROM ods.vw_VerticalResponse_Bounces a --all bounces, includes new
LEFT JOIN ods.VerticalResponse_Bounces b --materialized bounces
    ON a.CampaignID = b.CampaignID
    AND a.Email_Address = b.EmailAddress
    AND a.List_Name = b.List_Name
    AND a.Response_Date = b.Response_Date
WHERE b.ID IS NULL -- filters to only include new bounces not yet in the table


INSERT INTO ods.VerticalResponse_Bounces (CampaignID, List_Name, Response_Type, Response_Date, EmailAddress, ETL__CreatedDate, ETL__UpdatedDate)
SELECT CampaignID, List_Name, Response_Type, Response_Date, Email_Address, GETDATE(), GETDATE()
FROM #tmp
	
END
GO
