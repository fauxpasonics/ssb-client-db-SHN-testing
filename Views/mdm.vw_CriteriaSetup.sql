SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [mdm].[vw_CriteriaSetup]
AS
(

SELECT dc.dimcustomerID
	, CAST(av.MaxTicket AS DATETIME) AS MaxTicketPurchase
	, CAST(vr.MaxEmail AS DATETIME) AS MaxEmail
	, CAST(hw.MaxText AS DATETIME) AS MaxText
FROM dbo.DimCustomer dc
LEFT JOIN (
			SELECT dc.DimCustomerId, MAX(dv.stamp) MaxText
			FROM ods.HelloWorld_Subscribers s
			JOIN ods.HelloWorld_DatafieldValues dv ON s.subscriberid = dv.subscriberid
			JOIN dbo.dimcustomer dc ON s.phone = dc.ssid AND dc.SourceSystem = 'HelloWorld'
			WHERE CAST(dv.stamp AS DATE) > = (GETDATE() - 730)
			GROUP BY dc.DimCustomerId
		) hw ON dc.DimCustomerId = hw.DimCustomerId
LEFT JOIN (
			SELECT dc.DimCustomerId, MAX(ec.MailDate) MaxEmail
			FROM ods.VerticalResponse_EmailCampaigns ec
			JOIN ods.VerticalResponse_EmailCampaigns_Lists el
				ON ec.CampaignID = el.CampaignID
			JOIN ods.VerticalResponse_ListMembers lm
				ON el.ListID = lm.ListID
			JOIN dbo.DimCustomer dc
				ON lm.CID = dc.SSID
				AND dc.SourceSystem = 'VerticalResponse'
			WHERE CAST(ec.MailDate AS DATE) >= (GETDATE() - 730)
			GROUP BY dc.DimCustomerId
		) vr ON dc.DimCustomerId = vr.DimCustomerId
LEFT JOIN (
			SELECT dc.DimCustomerId, MAX(dd.CalDate) MaxTicket
			FROM dbo.FactTicketSales_V2 f
			JOIN dbo.DimTicketCustomer_V2 dtc
				ON f.DimTicketCustomerId = dtc.DimTicketCustomerId
			JOIN dbo.DimCustomer dc
				ON dtc.ETL__SourceSystem = dc.SourceSystem
				AND dtc.ETL__SSID = dc.SSID
			JOIN dbo.DimDate dd
				ON f.DimDateId = dd.DimDateId
			WHERE CAST(dd.CalDate AS DATE) >= (GETDATE() - 730)
			GROUP BY dc.DimCustomerId
		) av ON dc.DimCustomerId = av.DimCustomerId






);







GO
