CREATE TABLE [dbo].[Contact_CustomFields]
(
[SSB_CRMSYSTEM_CONTACT_ID] [uniqueidentifier] NULL,
[PrimaryCustomerNumber] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AllCustomerNumbers] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AreaCode] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSF] [bit] NULL,
[IsBayArea] [bit] NULL,
[IsNorCal] [bit] NULL,
[IsCurrentMember] [bit] NULL,
[FirstMembershipSeason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastMembershipSeason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MembershipSeasons] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[FirstSeries] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstPerformance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstPerformanceDate] [datetime] NULL,
[MostRecentSeries] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MostRecentPerformance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MostRecentPerformanceDate] [datetime] NULL,
[NextUpcomingSeries] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NextUpcomingPerformance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NextUpcomingPerformanceDate] [datetime] NULL,
[AllSeries] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountCYSeries] [int] NULL,
[CountPYSeries] [int] NULL,
[CountTotalSeries] [int] NULL,
[CountCYPerformances] [int] NULL,
[CountPYPerformances] [int] NULL,
[CountTotalPerformances] [int] NULL,
[LifetimeValue] [decimal] (18, 6) NULL,
[CYSpend] [decimal] (18, 6) NULL,
[PYSpend] [decimal] (18, 6) NULL,
[AvgTicketsPerPerformance] [decimal] (18, 6) NULL,
[TotalTickets] [int] NULL,
[CYTickets] [int] NULL,
[PYTickets] [int] NULL,
[IsHamiltonBuyer] [bit] NULL,
[IsTodayTixBuyer] [bit] NULL,
[IsHamiltonLotteryBuyer] [bit] NULL,
[VREmailLists] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VRLastEmailReceived] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VREmailOpenPcnt] [decimal] (18, 6) NULL,
[MostCommonShowType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NCOAStatus] [bit] NULL,
[SubscriptionShows] [int] NULL,
[NonSubscriptionShows] [int] NULL,
[RepeatShows] [int] NULL,
[PremiereShows] [int] NULL,
[MusicalShows] [int] NULL,
[AudioVisualShows] [int] NULL,
[Plays] [int] NULL,
[Events] [int] NULL,
[Concerts] [int] NULL,
[Lectures] [int] NULL,
[Conversations] [int] NULL,
[SpecialEngagements] [int] NULL,
[SingleShows] [int] NULL,
[Season39] [int] NULL,
[Season40] [int] NULL,
[Season41] [int] NULL,
[Season42] [int] NULL,
[Season43] [int] NULL,
[Season44] [int] NULL,
[Season45] [int] NULL,
[Season46] [int] NULL,
[Season47] [int] NULL,
[InHelloWorld] [bit] NULL,
[InHamilton] [bit] NULL,
[InTodayTix] [bit] NULL,
[InAudienceView] [bit] NULL,
[InVerticalResponse] [bit] NULL,
[InVividSeats] [bit] NULL,
[InSurveyMonkey] [bit] NULL,
[TotalYearsAsMember] [int] NULL,
[FirstTimeBuyer] [bit] NULL,
[FirstTimeMember] [bit] NULL,
[AvgTicketPrice] [decimal] (18, 6) NULL,
[TodayTixCYSeries] [int] NULL,
[TodayTixPYSeries] [int] NULL,
[TodayTixTotalSeries] [int] NULL,
[IsPriorMember] [bit] NULL,
[SingleShowFullPricePerformancesCY] [int] NULL,
[SingleShowFullPriceSeriesCY] [int] NULL,
[SingleShowFullPricePerformancesPY] [int] NULL,
[SingleShowFullPriceSeriesPY] [int] NULL,
[VividSeatsCYPerformances] [int] NULL,
[VividSeatsCYSeries] [int] NULL,
[VividSeatsPYPerformances] [int] NULL,
[VividSeatsPYSeries] [int] NULL,
[VividSeatsTotalPerformances] [int] NULL,
[VividSeatsTotalSeries] [int] NULL,
[IsGroupBuyer] [bit] NULL,
[IsGroupCorpBuyer] [bit] NULL,
[IsADABuyer] [bit] NULL,
[AccountClassificationID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LegacyAccountNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomerUsername] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountLinkage] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MostRecentPromoCode] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsGiftCardBuyer] [bit] NULL,
[MinCustomerCreateDate] [datetime] NULL,
[TicketScanPercentage] [decimal] (10, 2) NULL,
[VREmailDeliveries] [int] NULL,
[VREmailOpens] [int] NULL,
[IsOlderMember] [bit] NULL
)
GO
CREATE NONCLUSTERED INDEX [IX_FlagFields] ON [dbo].[Contact_CustomFields] ([IsSF], [IsBayArea], [IsNorCal], [IsCurrentMember], [IsActive], [IsHamiltonBuyer], [IsTodayTixBuyer], [IsHamiltonLotteryBuyer], [NCOAStatus], [InHelloWorld], [InHamilton], [InTodayTix], [InAudienceView], [InVerticalResponse], [InVividSeats], [InSurveyMonkey])
GO
CREATE NONCLUSTERED INDEX [IX_CustomerNumbers] ON [dbo].[Contact_CustomFields] ([SSB_CRMSYSTEM_CONTACT_ID], [PrimaryCustomerNumber], [AllCustomerNumbers])
GO
