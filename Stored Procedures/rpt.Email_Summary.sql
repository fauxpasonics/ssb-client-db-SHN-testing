SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE
[rpt].[Email_Summary]

AS
--Group 1

SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID
INTO #no_open
FROM etl.VerticalResponse_EmailCampaign_Activity WITH (NOLOCK)
GROUP BY SSB_CRMSYSTEM_CONTACT_ID
HAVING SUM(OpenCount) = 0

--DROP TABLE #opens

SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID, MAX(MaxOpenDate) AS MaxOpenDate
INTO #opens
FROM etl.VerticalResponse_EmailCampaign_Activity WITH (NOLOCK)
GROUP BY SSB_CRMSYSTEM_CONTACT_ID
HAVING SUM(OpenCount) > 0


--Group 2

SELECT *
INTO #opens_30_days
FROM #opens
WHERE MaxOpenDate >= DATEADD(DAY,-30,GETDATE())


SELECT *
INTO #opens_60_days
FROM #opens
WHERE MaxOpenDate >= DATEADD(DAY,-60,GETDATE())
AND MaxOpenDate <= DATEADD(DAY,-30,GETDATE())



SELECT *
INTO #opens_90_days
FROM #opens
WHERE MaxOpenDate >= DATEADD(DAY,-90,GETDATE())
AND MaxOpenDate <= DATEADD(DAY,-60,GETDATE())


SELECT *
INTO #opens_120_days
FROM #opens
WHERE MaxOpenDate >= DATEADD(DAY,-120,GETDATE())
AND MaxOpenDate <= DATEADD(DAY,-90,GETDATE())


SELECT *
INTO #opens_365_days
FROM #opens
WHERE MaxOpenDate >= DATEADD(DAY,-365,GETDATE())
AND MaxOpenDate <= DATEADD(DAY,-120,GETDATE())

--Group 3

SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(DISTINCT CampaignID) AS [Emails_Sent], SUM(CASE WHEN OpenCount > 0 THEN 1 ELSE 0 END) AS [Emails_Opened]
INTO #open_summary
FROM etl.VerticalResponse_EmailCampaign_Activity WITH (NOLOCK)
GROUP BY SSB_CRMSYSTEM_CONTACT_ID


SELECT *, CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent AS [Open_Percentage]
INTO #open_over50
FROM #open_summary
WHERE CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent >= .5


SELECT *, CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent AS [Open_Percentage]
INTO #open_over25
FROM #open_summary
WHERE CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent < .5
AND CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent >= .25


SELECT *, CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent AS [Open_Percentage]
INTO #open_over10
FROM #open_summary
WHERE CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent < .25
AND CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent >= .1


SELECT *, CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent AS [Open_Percentage]
INTO #open_under10
FROM #open_summary
WHERE CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent < .1
AND CAST(Emails_Opened AS DECIMAL(18,8))/Emails_Sent > 0


---all_tickets

SELECT DISTINCT acct.SSB_CRMSYSTEM_CONTACT_ID, MAX(OrderDate) AS [Last_purchase_date]
INTO #all_tickets
FROM dbo.FactTicketSales_V2 fts
  INNER JOIN dbo.vwDimCustomer_ModAcctId acct ON fts.DimTicketCustomerId = acct.DimCustomerId
GROUP BY acct.SSB_CRMSYSTEM_CONTACT_ID

SELECT *
INTO #tickets_last_30
FROM #all_tickets
WHERE Last_purchase_date >= DATEADD(DAY,-30,GETDATE())

SELECT *
INTO #tickets_last_60
FROM #all_tickets
WHERE Last_purchase_date < DATEADD(DAY,-30,GETDATE())
AND 
Last_purchase_date >= DATEADD(DAY,-60,GETDATE())


SELECT *
INTO #tickets_last_90
FROM #all_tickets
WHERE Last_purchase_date < DATEADD(DAY,-60,GETDATE())
AND 
Last_purchase_date >= DATEADD(DAY,-90,GETDATE())

SELECT *
INTO #tickets_last_120
FROM #all_tickets
WHERE Last_purchase_date < DATEADD(DAY,-90,GETDATE())
AND 
Last_purchase_date >= DATEADD(DAY,-120,GETDATE())

SELECT *
INTO #tickets_last_365
FROM #all_tickets
WHERE Last_purchase_date < DATEADD(DAY,-120,GETDATE())
AND 
Last_purchase_date >= DATEADD(DAY,-365,GETDATE())

--Group 4


SELECT DISTINCT #opens.SSB_CRMSYSTEM_CONTACT_ID INTO #email_and_ticket FROM #opens INNER JOIN #all_tickets ON #all_tickets.SSB_CRMSYSTEM_CONTACT_ID = #opens.SSB_CRMSYSTEM_CONTACT_ID

SELECT DISTINCT #opens.SSB_CRMSYSTEM_CONTACT_ID INTO #email_no_ticket FROM #opens LEFT OUTER JOIN #all_tickets ON #all_tickets.SSB_CRMSYSTEM_CONTACT_ID = #opens.SSB_CRMSYSTEM_CONTACT_ID WHERE #all_tickets.SSB_CRMSYSTEM_CONTACT_ID IS NULL

SELECT DISTINCT #all_tickets.SSB_CRMSYSTEM_CONTACT_ID INTO #ticket_no_email FROM #opens RIGHT OUTER JOIN #all_tickets ON #all_tickets.SSB_CRMSYSTEM_CONTACT_ID = #opens.SSB_CRMSYSTEM_CONTACT_ID WHERE #opens.SSB_CRMSYSTEM_CONTACT_ID IS NULL

SELECT DISTINCT #no_open.SSB_CRMSYSTEM_CONTACT_ID INTO #no_email_no_ticket FROM #no_open LEFT OUTER JOIN #all_tickets ON #all_tickets.SSB_CRMSYSTEM_CONTACT_ID = #no_open.SSB_CRMSYSTEM_CONTACT_ID WHERE #all_tickets.SSB_CRMSYSTEM_CONTACT_ID IS NULL


--Group 5


SELECT DISTINCT #opens_30_days.SSB_CRMSYSTEM_CONTACT_ID INTO #tickets_opens_30 FROM #opens_30_days INNER JOIN #tickets_last_30 ON #tickets_last_30.SSB_CRMSYSTEM_CONTACT_ID = #opens_30_days.SSB_CRMSYSTEM_CONTACT_ID

SELECT DISTINCT #opens_60_days.SSB_CRMSYSTEM_CONTACT_ID INTO #tickets_opens_60 FROM #opens_60_days INNER JOIN #tickets_last_60 ON #tickets_last_60.SSB_CRMSYSTEM_CONTACT_ID = #opens_60_days.SSB_CRMSYSTEM_CONTACT_ID

SELECT DISTINCT #opens_90_days.SSB_CRMSYSTEM_CONTACT_ID INTO #tickets_opens_90 FROM #opens_90_days INNER JOIN #tickets_last_90 ON #tickets_last_90.SSB_CRMSYSTEM_CONTACT_ID = #opens_90_days.SSB_CRMSYSTEM_CONTACT_ID

SELECT DISTINCT #opens_120_days.SSB_CRMSYSTEM_CONTACT_ID INTO #tickets_opens_120 FROM #opens_120_days INNER JOIN #tickets_last_120 ON #tickets_last_120.SSB_CRMSYSTEM_CONTACT_ID = #opens_120_days.SSB_CRMSYSTEM_CONTACT_ID

SELECT DISTINCT #opens_365_days.SSB_CRMSYSTEM_CONTACT_ID INTO #tickets_opens_365 FROM #opens_365_days INNER JOIN #tickets_last_365 ON #tickets_last_365.SSB_CRMSYSTEM_CONTACT_ID = #opens_365_days.SSB_CRMSYSTEM_CONTACT_ID


---Summaries
--Group 1

SELECT a.[People who have not opened email], b.[People who have opened email]
FROM
(
	SELECT COUNT(DISTINCT #no_open.SSB_CRMSYSTEM_CONTACT_ID) AS [People who have not opened email]
	FROM #no_open
) a CROSS JOIN
(
	SELECT COUNT(DISTINCT #opens.SSB_CRMSYSTEM_CONTACT_ID) AS [People who have opened email]
	FROM #opens
)b


--Group 2


SELECT a.*, b.*,
c.*, d.*, e.*
FROM
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email in 30 days]
	FROM #opens_30_days
) a CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email in 60 days]
	FROM #opens_60_days
)b
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email in 90 days]
	FROM #opens_90_days
)c
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email in 120 days]
	FROM #opens_120_days
)d
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email in 365 days]
	FROM #opens_365_days
)e

--Group 3

SELECT a.*, b.*,
c.*, d.*
FROM
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened over 50% of emails]
	FROM #open_over50
) a CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened over 25% of emails]
	FROM #open_over25
)b
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened over 10% of emails]
	FROM #open_over10
)c
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened under 10% of emails]
	FROM #open_under10
)d


--Group 4

SELECT a.*, b.*,
c.*, d.*
FROM
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened Email and bought ticket]
	FROM #email_and_ticket
) a CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened Email and did not buy ticket]
	FROM #email_no_ticket
)b
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Bought Ticket did not open email]
	FROM #ticket_no_email
)c
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Did not buy ticket or open email]
	FROM #no_email_no_ticket
)d

--Group 5

SELECT a.*, b.*,
c.*, d.*, e.*
FROM
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email and bought ticket in 30 days]
	FROM #tickets_opens_30
) a CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email and bought ticket in 60 days]
	FROM #tickets_opens_60
)b
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email and bought ticket in 90 days]
	FROM #tickets_opens_90
)c
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email and bought ticket in 120 days]
	FROM #tickets_opens_120
)d
CROSS JOIN
(
	SELECT COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS [Opened email and bought ticket in 365 days]
	FROM #tickets_opens_365
)e



DROP TABLE #all_tickets
DROP TABLE #email_and_ticket
DROP TABLE #email_no_ticket
DROP TABLE #no_email_no_ticket
DROP TABLE #no_open
DROP TABLE #opens
DROP TABLE #opens_120_days
DROP TABLE #opens_30_days
DROP TABLE #opens_365_days
DROP TABLE #opens_60_days
DROP TABLE #opens_90_days
DROP TABLE #open_over10
DROP TABLE #open_over25
DROP TABLE #open_over50
DROP TABLE #open_summary
DROP TABLE #open_under10
DROP TABLE #tickets_last_120
DROP TABLE #tickets_last_30
DROP TABLE #tickets_last_365
DROP TABLE #tickets_last_60
DROP TABLE #tickets_last_90
DROP TABLE #tickets_opens_120
DROP TABLE #tickets_opens_30
DROP TABLE #tickets_opens_365
DROP TABLE #tickets_opens_60
DROP TABLE #tickets_opens_90
DROP TABLE #ticket_no_email
GO
