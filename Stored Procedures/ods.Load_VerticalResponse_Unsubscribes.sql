SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[Load_VerticalResponse_Unsubscribes]
AS 
BEGIN
IF OBJECT_ID('TempDB..#unsub') IS NOT NULL 
DROP TABLE #unsub

SELECT a.CampaignID, a.List_Name, a.Response_Type, a.Response_Date, a.Email_Address
INTO #unsub
FROM ods.vw_VerticalResponse_Unsubscribes a --all unsubscribes, includes new
LEFT JOIN ods.VerticalResponse_Unsubscribes b --materialized unsubscribes
    ON a.CampaignID = b.CampaignID
    AND a.Email_Address = b.EmailAddress
    AND a.List_Name = b.List_Name
    AND a.Response_Date = b.Response_Date
WHERE b.ID IS NULL -- filters to only include new unsubscribes not yet in the table


INSERT INTO ods.VerticalResponse_Unsubscribes(CampaignID, List_Name, Response_Type, Response_Date, EmailAddress, ETL__CreatedDate, ETL__UpdatedDate)
SELECT CampaignID, List_Name, Response_Type, Response_Date, Email_Address, GETDATE(), GETDATE()
FROM #unsub
	
END
GO
