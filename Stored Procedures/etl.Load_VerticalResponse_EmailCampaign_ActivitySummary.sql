SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[Load_VerticalResponse_EmailCampaign_ActivitySummary]
AS

IF EXISTS (select * from sys.indexes where name = 'IDX_VR_EmailCampaign_ActivitySummary')
	DROP INDEX IDX_VR_EmailCampaign_ActivitySummary ON etl.VerticalResponse_EmailCampaign_ActivitySummary;

TRUNCATE TABLE etl.VerticalResponse_EmailCampaign_ActivitySummary

INSERT INTO etl.VerticalResponse_EmailCampaign_ActivitySummary (SSB_CRMSYSTEM_CONTACT_ID, MinMailDate, MaxMailDate, DeliveryCount
	, OpenCount, MinOpenDate, MaxOpenDate, ClickCount, MinClickDate, MaxClickDate, BounceCount, MinBounceDate, MaxBounceDate)

SELECT SSB_CRMSYSTEM_CONTACT_ID
	, MIN(MailDate) MinMailDate, MAX(MailDate) MaxMailDate
	, SUM(DeliveryCount) DeliveryCount
	, SUM(CASE WHEN OpenCount > 0 THEN 1 ELSE 0 END) OpenCount
	, MIN(MinOpenDate) MinOpenDate, MAX(MaxOpenDate) MaxOpenDate
	, SUM(CASE WHEN ClickCount > 0 THEN 1 ELSE 0 END) ClickCount
	, MIN(MinClickDate) MinClickDate, MAX(MaxClickDate) MaxClickDate
	, SUM(CASE WHEN OpenCount > 0 THEN 1 ELSE 0 END) BounceCount
	, MIN(MinBounceDate) MinBounceDate, MAX(MaxBounceDate) MaxBounceDate
FROM etl.VerticalResponse_EmailCampaign_Activity
GROUP BY SSB_CRMSYSTEM_CONTACT_ID



IF NOT EXISTS (select * from sys.indexes where name = 'IDX_VR_EmailCampaign_ActivitySummary')
	CREATE NONCLUSTERED INDEX IDX_VR_EmailCampaign_ActivitySummary on etl.VerticalResponse_EmailCampaign_ActivitySummary (SSB_CRMSYSTEM_CONTACT_ID);

GO
