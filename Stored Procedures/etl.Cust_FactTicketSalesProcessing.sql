SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[Cust_FactTicketSalesProcessing]
(
	@BatchId NVARCHAR (50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = NULL
)

AS



BEGIN

/*****************************************************************************************************************
												Ticket Type
******************************************************************************************************************/
-- Bundle Week 1 --
UPDATE f
SET DimTicketTypeID = 1
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE (LEFT(bundle.PlanName,3) IN ('471', '461', '451', '441', '431', '421'))
	OR bundle.PlanName like 'New 431%'
	OR bundle.PlanName LIKE '5 4111%'
	OR LEFT(bundle.PlanName, 4) IN ('N411', 'R411')
	OR bundle.PlanName LIKE '%401%'



-- Bundle Week 2 --
UPDATE f
SET DimTicketTypeID = 2
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE (LEFT(bundle.PlanName, 3) IN ('472', '462', '452', '442', '432', '422'))
	OR bundle.PlanName LIKE 'New 432%'
	OR bundle.PlanName LIKE '5 4112%'
	OR LEFT(bundle.PlanName, 4) IN ('N412', 'R412')
	OR bundle.PlanName LIKE '%402%'


-- Bundle Week 3 --
UPDATE f
SET DimTicketTypeID = 3
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE LEFT(bundle.PlanName, 3) IN ('473', '463', '453', '443', '433', '423')
	OR bundle.PlanName LIKE 'New 433%'
	OR bundle.PlanName LIKE '5 4113%'
	OR LEFT(bundle.PlanName, 4) IN ('N413', 'R413')
	OR bundle.PlanName LIKE '%403%'


-- Bundle Week 4 --
UPDATE f
SET DimTicketTypeID = 4
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE LEFT(bundle.PlanName, 3) IN ('474', '464', '454', '444', '434', '424')
	OR bundle.PlanName LIKE 'New 434%'
	OR bundle.PlanName LIKE '5 4114%'
	OR LEFT(bundle.PlanName, 4) IN ('N414', 'R414')
	OR bundle.PlanName LIKE '%404%'


-- Corporate Offer --
UPDATE f
SET DimTicketTypeID = 5
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
LEFT JOIN dbo.DimPromo_V2 promo ON f.DimPromoId = promo.DimPromoId
WHERE pricetype.AV_price_type_group = 'group'
	AND ((promo.PromoCode NOT IN ('Season 47', 'Season 46', 'Season 45', 'Season 44'
		, 'Season 43', 'First Access', 'Season 41')
		AND f.DimPromoId <> -1)
	OR (season.SeasonName IN ('Season 39', 'Season 40') AND pricetype.PriceTypeName LIKE '%group corp%'))
	AND f.DimTicketTypeId = -1


-- Group --
UPDATE f
SET DimTicketTypeID = 10
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE pricetype.AV_price_type_group = 'group'
	AND ((season.SeasonName IN ('Season 41', 'Season 42', 'Season 43', 'Season 44', 'Season 45'
		, 'Season 46', 'Season 47') AND f.DimPromoID = -1)
	OR (season.SeasonName IN ('Season 39', 'Season 40') AND PriceTypeName NOT LIKE '%group corp%'))
	AND f.DimTicketTypeId = -1



-- Single Show - Members --
UPDATE f
SET DimTicketTypeID = 6
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN dbo.DimPromo_V2 promo ON f.DimPromoId = promo.DimPromoId
WHERE --promo.PromoCode IN ('Season 47', 'Season 46', 'Season 45', 'Season 44', 'Season'
		--, 'Season 43', 'First Access', '2 additional member tickets')
	PriceTypeName IN ('Member Single', 'Member Single ADA', 'Member Special', 'Member Special ADA'
		, 'z2017 Ham Member Single', 'z2017 Ham Member Single ADA')
	OR (season.SeasonName IN ('Season 39', 'Season 40', 'Season 41')
		AND pricetype.AV_price_type_group = 'singles' AND pricetype.PriceTypeName LIKE '%Sub Single%')
	AND f.DimTicketTypeId = -1



-- Single Show - Non Members --
UPDATE f
SET DimTicketTypeID = 7
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN dbo.DimPromo_V2 promo ON f.DimPromoId = promo.DimPromoId
WHERE pricetype.AV_price_type_group = 'singles'
	--AND (promo.PromoCode NOT IN ('Season 47', 'Season 46', 'Season 45', 'Season 44'
	--	, 'Season', 'Season 43', 'First Access', '2 additional member tickets')
	AND (PriceTypeName NOT IN ('Member Single', 'Member Single ADA', 'Member Special', 'Member Special ADA'
		, 'z2017 Ham Member Single', 'z2017 Ham Member Single ADA')
	OR (season.SeasonName IN ('Season 39', 'Season 40', 'Season 41') AND PriceTypeName NOT LIKE '%sub single%'))
	AND f.DimTicketTypeId = -1


-- Subscription Show - Members --
UPDATE f
SET DimTicketTypeID = 8
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN dbo.DimPromo_V2 promo ON f.DimPromoId = promo.DimPromoId
WHERE pricetype.AV_price_type_group = 'subscription'
	AND promo.PromoCode NOT IN ('Season 47', 'Season 46', 'Season 45', 'Season 44'
		, 'Season', 'Season 43', 'First Access')
	AND f.DimTicketTypeId = -1



-- Comp --
UPDATE f
SET DimTicketTypeID = 9
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
LEFT JOIN dbo.DimPromo_V2 promo ON f.DimPromoId = promo.DimPromoId
WHERE pricetype.AV_price_type_group = 'comp' AND bundle.PlanName NOT LIKE 'SHN Choice%'
	AND f.DimTicketTypeId = -1



-- Unseated New --
UPDATE f
SET DimTicketTypeID = 11
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN dbo.DimPromo_V2 promo ON f.DimPromoId = promo.DimPromoId
WHERE season.SeasonName = 'Season 47'
	AND (bundle.PlanName LIKE 'Tuesday%' OR bundle.PlanName LIKE 'Wednesday%' OR bundle.PlanName LIKE 'Thursday%'
		OR bundle.PlanName LIKE 'Friday%' OR bundle.PlanName LIKE 'Saturday%' OR bundle.PlanName LIKE 'Sunday%')
	AND f.DimTicketTypeId = -1



-- Bundle Choice --
UPDATE f
SET DimTicketTypeID = 12
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE season.SeasonName = 'Season 41' AND bundle.PlanName LIKE 'SHN Choice%'
	AND f.DimTicketTypeId = -1


	


/*****************************************************************************************************************
													PLAN TYPE
******************************************************************************************************************/
-- New --
UPDATE f
SET DimPlanTypeID = 1
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN ods.AV_ts_order ord ON f.ETL__SSID_AV_order_id = ord.order_id
WHERE ((pricetype.PriceTypeName IN ('4Prime New', '4Season New', '4Season New Accessible', 'Prime New'
		, 'Season New', 'Season New Accessible', 'Sub Combo New', 'Sub New', 'Subscriber Combo New'
		, 'Subscriber New', 'Subscriber New Accessible', 'ZZ Sub Access 3', 'ZZ Sub Access 4'
		, 'ZZ Subscription 3', 'ZZ Subscription 4', 'ZZ Subscription Starter', 'ZZ TSub Access 3'
		, 'ZZ TSub Access 4', 'ZZ TSubscription 3', 'ZZ TSubscription 4', 'ZZ TSubscription Starter'))
	OR (bundle.PlanName LIKE 'N%' OR bundle.PlanName LIKE '5%')
	OR (pricetype.PriceTypeName IN ('Sub Access', 'Subscription') AND ISNULL(ord.order_type, '') = 'S'))
	AND f.DimPlanTypeId = -1
		



-- Renew --
UPDATE f
SET DimPlanTypeID = 2
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN ods.AV_ts_order ord ON f.ETL__SSID_AV_order_id = ord.order_id
WHERE ((pricetype.PriceTypeName IN ('Prime Renew', 'Season Renew', 'Season Renew Accessible', 'Sub Renew'
		, 'Subscriber Renew', 'Subscriber Renew Accessible', 'Z-Opt Out: 3 out of 6 Accessible'
		, 'Z-Opt Out: Beautiful', 'Z-Opt Out: Beautiful Accessible', 'Z-Opt Out: Beautiful and Cabaret'
		, 'Z-Opt Out: Cabaret Accessible', 'Z-Opt Out: Hedwig', 'Z-Opt Out: Hedwig 4 New'
		, 'Z-Opt Out: Hedwig Accessible', 'Z-Opt Out: If Then', 'Z-Opt Out: Lion King'
		, 'Z-Opt Out: Lion King Accessible', 'Z-Opt Out: Peter and the Starcatcher', 'Z-Opt Out: Phantom'
		, 'Z-Opt Out: Wicked', 'Z-Opt Out: Wicked Accessible', 'Z-Opt Out: Wicked+Book of Mormon'
		, 'Z-Prime: Motown+Kinky Boots ONLY', 'Z-Prime Opt Out: 4 out of 6', 'Z-Prime Opt Out: Beautiful'
		, 'Z-Prime Opt Out: Beautiful and Cabaret', 'Z-Prime Opt Out: Cabaret', 'Z-Prime Opt Out: Hedwig'
		, 'Z-Prime Opt Out: If Then', 'Z-Prime Opt Out: Lion King', 'Z-Prime Opt Out: Phantom'
		, 'Z-Prime Opt Out: Wicked', 'Z-Prime Opt Out: Wicked+Lion King', 'ZZ No Billy'
		, 'ZZ No Billy 3', 'ZZ No Billy 4', 'ZZ No Blue', 'ZZ No Blue Access', 'ZZ Shrek Only'))
	OR bundle.PlanName LIKE 'R%'
	OR (pricetype.PriceTypeName IN ('Sub Access', 'Subscription') AND ISNULL(ord.order_type, '') IN ('R', 'RD')))
	AND f.DimPlanTypeId = -1




-- Unseated --
UPDATE f
SET f.DimPlanTypeId = 4
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceTypeName LIKE 'Section%' AND f.DimPlanTypeId = -1



-- Choice --
UPDATE f
SET f.DimPlanTypeId = 5
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceTypeName IN ('EXP SHN Plan', 'EXP SHN PlanT', 'SHN Plan', 'SHN Plan Accessible', 'SHN PlanT'
	, 'SHN PlanT Accessible') AND f.DimPlanTypeId = -1



-- No Plan --
UPDATE f
SET DimPlanTypeID = 3
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
LEFT JOIN ods.AV_ts_order ord ON f.ETL__SSID_AV_order_id = ord.order_id
WHERE f.DimPlanTypeId = -1
/*WHERE pricetype.PriceTypeName NOT IN ('4Prime New', '4Season New', '4Season New Accessible', 'Prime New'
		, 'Season New', 'Season New Accessible', 'Sub Combo New', 'Sub New', 'Subscriber Combo New'
		, 'Subscriber New', 'Subscriber New Accessible', 'ZZ Sub Access 3', 'ZZ Sub Access 4'
		, 'ZZ Subscription 3', 'ZZ Subscription 4', 'ZZ Subscription Starter', 'ZZ TSub Access 3'
		, 'ZZ TSub Access 4', 'ZZ TSubscription 3', 'ZZ TSubscription 4', 'ZZ TSubscription Starter'
		, 'Prime Renew', 'Season Renew', 'Season Renew Accessible', 'Sub Renew'
		, 'Subsciber Renew', 'Subscriber Renew Accessible', 'Z-Opt Out: 3 out of 6 Accessible'
		, 'Z-Opt Out: Beautiful', 'Z-Opt Out: Beautiful Accessible', 'Z-Opt Out: Beautiful and Cabaret'
		, 'Z-Opt Out: Cabaret Accessible', 'Z-Opt Out: Hedwig', 'Z-Opt Out: Hedwig 4 New'
		, 'Z-Opt Out: Hedwig Accessible', 'Z-Opt Out: If Then', 'Z-Opt Out: Lion King'
		, 'Z-Opt Out: Lion King Accessible', 'Z-Opt Out: Peter and the Starcatcher', 'Z-Opt Out: Phantom'
		, 'Z-Opt Out: Wicked', 'Z-Opt Out: Wicked Accessible', 'Z-Opt Out: Wicked+Book of Mormon'
		, 'Z-Prime: Motown+Kinky Boots ONLY', 'Z-Prime Opt Out: 4 out of 6', 'Z-Prime Opt Out: Beautiful'
		, 'Z-Prime Opt Out: Beautiful and Cabaret', 'Z-Prime Opt Out: Cabaret', 'Z-Prime Opt Out: Hedwig'
		, 'Z-Prime Opt Out: If Then', 'Z-Prime Opt Out: Lion King', 'Z-Prime Opt Out: Phantom'
		, 'Z-Prime Opt Out: Wicked', 'Z-Prime Opt Out: Wicked+Lion King', 'ZZ No Billy'
		, 'ZZ No Billy 3', 'ZZ No Billy 4', 'ZZ No Blue', 'ZZ No Blue Access', 'ZZ Shrek Only'
		, 'EXP SHN Plan', 'EXP SHN PlanT', 'SHN Plan', 'SHN Plan Accessible', 'SHN PlanT'
		, 'SHN PlanT Accessible', 'Sub Access', 'Subscription')
	AND LEFT(ISNULL(bundle.PlanName, ''), 1) NOT IN ('5', 'N', 'R')
	AND PriceTypeName NOT LIKE 'Section%'
	AND ISNULL(ord.order_type, '') NOT IN ('Renewed', 'New')
*/


/*****************************************************************************************************************
													TICKET CLASS
******************************************************************************************************************/
-- Bundle Week 1 New Tuesday Evening --
UPDATE f
SET DimTicketClassID = 1
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 1 New Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 2
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 1 New Wednesday Evening --
UPDATE f
SET DimTicketClassID = 3
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 1 New Thursday Evening --
UPDATE f
SET DimTicketClassID = 4
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 1 New Friday Evening --
UPDATE f
SET DimTicketClassID = 5
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 1 New Saturday Matinee --
UPDATE f
SET DimTicketClassID = 6
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 1 New Saturday Evening --
UPDATE f
SET DimTicketClassID = 7
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 1 New Sunday Matinee --
UPDATE f
SET DimTicketClassID = 8
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 1 Renew Tuesday Evening --
UPDATE f
SET DimTicketClassID = 9
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 1 Renew Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 10
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 1 Renew Wednesday Evening --
UPDATE f
SET DimTicketClassID = 11
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 1 Renew Thursday Evening --
UPDATE f
SET DimTicketClassID = 12
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 1 Renew Friday Evening --
UPDATE f
SET DimTicketClassID = 13
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 1 Renew Saturday Matinee --
UPDATE f
SET DimTicketClassID = 14
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 1 Renew Saturday Evening --
UPDATE f
SET DimTicketClassID = 15
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 1 Renew Sunday Matinee --
UPDATE f
SET DimTicketClassID = 16
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeId = 1 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 2 New Tuesday Evening --
UPDATE f
SET DimTicketClassID = 17
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 2 New Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 18
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 2 New Wednesday Evening --
UPDATE f
SET DimTicketClassID = 19
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 2 New Thursday Evening --
UPDATE f
SET DimTicketClassID = 20
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 2 New Friday Evening --
UPDATE f
SET DimTicketClassID = 21
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 2 New Saturday Matinee --
UPDATE f
SET DimTicketClassID = 22
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 2 New Saturday Evening --
UPDATE f
SET DimTicketClassID = 23
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 2 New Sunday Matinee --
UPDATE f
SET DimTicketClassID = 24
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 2 Renew Tuesday Evening --
UPDATE f
SET DimTicketClassID = 25
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 2 Renew Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 26
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 2 Renew Wednesday Evening --
UPDATE f
SET DimTicketClassID = 27
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 2 Renew Thursday Evening --
UPDATE f
SET DimTicketClassID = 28
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 2 Renew Friday Evening --
UPDATE f
SET DimTicketClassID = 29
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 2 Renew Saturday Matinee --
UPDATE f
SET DimTicketClassID = 30
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 2 Renew Saturday Evening --
UPDATE f
SET DimTicketClassID = 31
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 2 Renew Sunday Matinee --
UPDATE f
SET DimTicketClassID = 32
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 2 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 3 New Tuesday Evening --
UPDATE f
SET DimTicketClassID = 33
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 3 New Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 34
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 3 New Wednesday Evening --
UPDATE f
SET DimTicketClassID = 35
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 3 New Thursday Evening --
UPDATE f
SET DimTicketClassID = 36
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 3 New Friday Evening --
UPDATE f
SET DimTicketClassID = 37
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 3 New Saturday Matinee --
UPDATE f
SET DimTicketClassID = 38
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 3 New Saturday Evening --
UPDATE f
SET DimTicketClassID = 39
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 3 New Sunday Matinee --
UPDATE f
SET DimTicketClassID = 40
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 3 Renew Tuesday Evening --
UPDATE f
SET DimTicketClassID = 41
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 3 Renew Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 42
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 3 Renew Wednesday Evening --
UPDATE f
SET DimTicketClassID = 43
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 3 Renew Thursday Evening --
UPDATE f
SET DimTicketClassID = 44
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 3 Renew Friday Evening --
UPDATE f
SET DimTicketClassID = 45
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 3 Renew Saturday Matinee --
UPDATE f
SET DimTicketClassID = 46
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 3 Renew Saturday Evening --
UPDATE f
SET DimTicketClassID = 47
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 3 Renew Sunday Matinee --
UPDATE f
SET DimTicketClassID = 48
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 3 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 4 New Tuesday Evening --
UPDATE f
SET DimTicketClassID = 49
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 4 New Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 50
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 4 New Wednesday Evening --
UPDATE f
SET DimTicketClassID = 51
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 4 New Thursday Evening --
UPDATE f
SET DimTicketClassID = 52
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 4 New Friday Evening --
UPDATE f
SET DimTicketClassID = 53
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 4 New Saturday Matinee --
UPDATE f
SET DimTicketClassID = 54
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 4 New Saturday Evening --
UPDATE f
SET DimTicketClassID = 55
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 4 New Sunday Matinee --
UPDATE f
SET DimTicketClassID = 56
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 1 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Bundle Week 4 Renew Tuesday Evening --
UPDATE f
SET DimTicketClassID = 57
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Tuesday Evening%'



-- Bundle Week 4 Renew Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 58
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Matinee%'



-- Bundle Week 4 Renew Wednesday Evening --
UPDATE f
SET DimTicketClassID = 59
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Wednesday Evening%'



-- Bundle Week 4 Renew Thursday Evening --
UPDATE f
SET DimTicketClassID = 60
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Thursday Evening%'



-- Bundle Week 4 Renew Friday Evening --
UPDATE f
SET DimTicketClassID = 61
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Friday Evening%'



-- Bundle Week 4 Renew Saturday Matinee --
UPDATE f
SET DimTicketClassID = 62
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Matinee%'



-- Bundle Week 4 Renew Saturday Evening --
UPDATE f
SET DimTicketClassID = 63
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Saturday Evening%'



-- Bundle Week 4 Renew Sunday Matinee --
UPDATE f
SET DimTicketClassID = 64
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 4 AND DimPlanTypeID = 2 AND bundle.PlanName LIKE '%Sunday Matinee%'



-- Group Student --
UPDATE f
SET DimTicketClassID = 65
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 10 AND DimPlanTypeID = 3
	AND (pricetype.PriceTypeName IN ('Group Student', 'Champion Group Student'))



-- Group ADA --
UPDATE f
SET DimTicketClassID = 66
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 10 AND DimPlanTypeID = 3
	AND (pricetype.PriceTypeName IN ('Group ADA', 'Ham Group ADA', '1110 Group ADA', 'Group K ADA', 'Champion Group ADA'
		, 'Group Access Les Miz', 'Group2 Access'))



-- Group --
UPDATE f
SET DimTicketClassID = 67
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 10 AND DimPlanTypeID = 3
	AND (pricetype.PriceTypeName IN ('Group', 'Ham Group', 'Group II', 'Two Pack: Group+Youth (under 15)', '1110 Group', 'Group K'
		, 'Champion Group', 'Group 2', 'EXP Group', 'Group Early', 'Group Les Miz', 'Group2', 'Group3', 'Group Early'))



-- Corporate Offer Group Corp --
UPDATE f
SET DimTicketClassID = 68
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 5 AND DimPlanTypeID = 3
	AND (pricetype.PriceTypeName IN ('Group Corp', 'Two Pack: GCorp+Youth (under 15)', '1110 Group Corp', 'HRC Group Corp', 'BOM Corp'
		, 'Group Corp Les Miz', 'Group2 Corp', 'ZZ Group Corp (A)'))



-- Corporate Offer Special Offer --
UPDATE f
SET DimTicketClassID = 69
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 5 AND DimPlanTypeID = 3
	AND (pricetype.PriceTypeName IN ('Amazon', 'Battery', 'Boy Scout Group', 'Boy Scout Group ADA', 'Girl Scout Group'
		, 'Cal Berkley', 'GOPRO', 'Skyline', 'UCSF', 'SFZOO', 'HRC Group Corp', '*LGBTQ', 'AARP', 'Academy of Friends'
		, 'Got Your 6', 'HMI PRIME', 'HRC Group Night', 'Human Rights', 'SF Aids Foundation', 'Trevor', 'Facebook'
		, 'Girl Scout 10', 'Google', 'Sisters', 'Twitter', 'University Group', 'SHN Events', 'Group CPMC', 'Group Dreamworks', 'Group JHC'
		, 'Twitter', 'ZZ Group NAMI', 'ZZ Group Normal','Google Group'))



-- Single Show - Member Single --
UPDATE f
SET DimTicketClassID = 70
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
--JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 6 AND DimPlanTypeID = 3
	AND pricetype.AV_price_type_group = 'Singles'
	AND (pricetype.PriceTypeName IN ('Member Single', '1110 Member Single'
			, 'z2017 HAM Member Single', 'Sub Single', 'Sub Single BOM'
			, 'Sub Single Premium', 'EXP Sub Single'))




-- Single Show - Member Single ADA --
UPDATE f
SET DimTicketClassID = 71
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 6 AND DimPlanTypeID = 3
	AND pricetype.AV_price_type_group = 'Singles'
	AND (pricetype.PriceTypeName IN ('Member Single ADA', 'Sub Single Access'
		, 'BOM Sub Single Accessible', 'Sub Single Accessible'
		, 'z2017 Ham Member Single ADA'))



-- Single Show - Member Special --
UPDATE f
SET DimTicketClassID = 72
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimEvent_V2 perf ON f.DimEventId = perf.DimEventId
JOIN dbo.DimEventHeader_V2 series ON perf.AV_series_id = series.ETL__SSID_AV_series_id
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 6 AND DimPlanTypeID = 3
	AND (pricetype.AV_price_type_group = 'Member' AND pricetype.PriceTypeName IN ('Member Special', '47 Member Special', 'Mormon Member Special'
		, 'Potter Member Special', 'VIP Meet/Greet Mem', 'Meet/Greet Mem', 'Member Special MG', 'Member Special New', 'Member Special Super50'
		, 'Two Pack: Member+Youth (under 15)'))
	OR (pricetype.AV_price_type_group = 'Subscription' AND series.EventName IN ('Mamma Mia!', 'Spamalot') AND PriceTypeName = 'Subscription')



-- Single Show - Member Special ADA --
UPDATE f
SET DimTicketClassID = 73
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimEvent_V2 perf ON f.DimEventId = perf.DimEventId
JOIN dbo.DimEventHeader_V2 series ON perf.AV_series_id = series.ETL__SSID_AV_series_id
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 6 AND DimPlanTypeID = 3
	AND (pricetype.AV_price_type_group = 'Member' AND pricetype.PriceTypeName IN ('Member Special ADA', '47 Member Special ADA'
		, 'Mormon Member Special Accessible', 'Member Special Accessible'))
	OR (pricetype.AV_price_type_group = 'Subscription' AND series.EventName IN ('Mamma Mia!', 'Spamalot') AND pricetype.PriceTypeName = 'Sub Access')



-- Subscription Show - Member --
UPDATE f
SET DimTicketClassID = 74
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 8 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Member'
	AND (pricetype.PriceTypeName IN ('Member', 'Member Corp', 'Section 1 * Orchestra - 4 Show', 'Section 2 * Mezzanine - 4 Show'
		, 'Section 3 * Balcony - 4 Show', 'STS', '1110 Member', 'Subs Premium', 'Subs 1027A'))



-- Subscription Show - Member ADA --
UPDATE f
SET DimTicketClassID = 75
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 8 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Member'
	AND (pricetype.PriceTypeName IN ('Member ADA', 'STS ADA', '1110 Member ADA', 'Sub Access', 'Subs Acc 1027A'))




-- Single Show - Non Member Rush/Discount --
UPDATE f
SET DimTicketClassID = 76
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 7 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Singles'
	AND (pricetype.PriceTypeName IN ('Goldstar', 'Goldstar ADA', 'Rush', 'TT Rush', 'Lottery', 'Non Lottery 40', 'Non Lottery 50'
		, 'TodayTix', 'TT Rush', 'Goldstar II', 'Goldstar II ADA', 'Groupon', 'Goldstar Mezz', 'Goldstar Orch', 'Non Lottery'
		, 'Online Lottery', '21Thirtyfive', 'Arts Offer', 'Booth', 'Cheer', 'Goldstar Cyber', 'Half Price Offer', 'Idiot Club'
		, 'KBLX Offer', 'Online Rush', 'Rush Student', 'Special Offer', 'Family', 'Gilt City $70', 'Gilt City VIP $95', 'Young Pro'
		, 'ZZ VH1C', 'D20', 'Discount', 'Gilt'))



-- Single Show - Non Member Single --
UPDATE f
SET DimTicketClassID = 77
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 7 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Singles'
	AND pricetype.PriceTypeName NOT IN ('1110 Group', '1110 Group ADA', '1110 Group Corp', '1110 Member', '1110 Member ADA'
		, '1110 Member Single', '21Thirtyfive', '47 Member Special', '47 Member Special ADA', 'AARP', 'Academy of Friends'
		, 'Amazon', 'Arts Offer', 'Battery', 'Booth', 'BOM Corp', 'BOM Sub Single Accessible', 'Boy Scout Group', 'Boy Scout Group ADA'
		, 'CAL Berkeley', 'Champion Group', 'Champion Group ADA', 'Champion Group Student', 'Cheer', 'D20', 'Discount'
		, 'EXP Group', 'EXP Sub Single', 'Facebook', 'Family', 'Gilt', 'Gilt City $70', 'Gilt City VIP $95', 'Girl Scout 10'
		, 'Girl Scout Group', 'Goldstar', 'Goldstar ADA', 'Goldstar Cyber', 'Goldstar II', 'Goldstar II ADA', 'Goldstar Mezz'
		, 'Goldstar Orch', 'Google', 'Google Group', 'GOPRO', 'Got Your 6', 'Group', 'Group 2', 'Group Access Les Miz', 'Group ADA'
		, 'Group Corp', 'Group Corp Les Miz', 'Group CPMC', 'Group Dreamworks', 'Group Early', 'Group II', 'Group JHC', 'Group K'
		, 'Group K ADA', 'Group Les Miz', 'Group Student', 'Group2 Access', 'Group2 Corp', 'Group3', 'Groupon', 'Half Price Offer'
		, 'Ham Group', 'Ham Group ADA', 'HMI PRIME', 'HRC Group Corp', 'HRC Group Night', 'Human Rights', 'Idiot Club', 'KBLX Offer'
		, '*LGBTQ', 'Lottery', 'Meet/Greet Mem', 'Member', 'Member ADA', 'Member Corp', 'Member Single', 'Member Single ADA'
		, 'Member Special', 'Member Special Accessible', 'Member Special ADA', 'Member Special MG', 'Member Special New'
		, 'Member Special Super50', 'Mormon Member Special Accessible', 'Mormon Member Special', 'Non Lottery', 'Non Lottery 40'
		, 'Non Lottery 50', 'Online Lottery', 'Online Rush', 'Potter Member Special', 'Rush', 'Rush Student', 'Section 1 * Orchestra - 4 Show'
		, 'Section 2 * Mezzanine - 4 Show', 'Section 3 * Balcony - 4 Show', 'SF Aids Foundation', 'SFZOO', 'SHN Events', 'Sisters'
		, 'Skyline', 'Special Offer', 'STS', 'STS ADA', 'Sub Access', 'Sub Single', 'Sub Single Access', 'Sub Single Accessible'
		, 'Sub Single BOM', 'Sub Single Premium', 'Subs 1027A', 'Subs Acc 1027A', 'Subs Premium', 'Subscription', 'TodayTix'
		, 'Trevor', 'TT Rush', 'Twitter', 'Two Pack: GCorp+Youth (under 15)', 'Two Pack: Group+Youth (under 15)'
		, 'Two Pack: Member+Youth (under 15)', 'UCSF', 'University Group', 'VIP Meet/Greet Mem', 'Young Pro', 'ZZ Group Corp (A)'
		, 'ZZ Group NAMI', 'ZZ Group Normal', 'ZZ VH1C') AND PriceTypeName NOT LIKE '%ADA' AND DimPromoID = -1



-- Single Show - Non Member Single ADA --
UPDATE f
SET DimTicketClassID = 78
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 7 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Singles'
	AND pricetype.PriceTypeName NOT IN ('1110 Group', '1110 Group ADA', '1110 Group Corp', '1110 Member', '1110 Member ADA'
		, '1110 Member Single', '21Thirtyfive', '47 Member Special', '47 Member Special ADA', 'AARP', 'Academy of Friends'
		, 'Amazon', 'Arts Offer', 'Battery', 'Booth', 'BOM Corp', 'BOM Sub Single Accessible', 'Boy Scout Group', 'Boy Scout Group ADA'
		, 'CAL Berkeley', 'Champion Group', 'Champion Group ADA', 'Champion Group Student', 'Cheer', 'D20', 'Discount'
		, 'EXP Group', 'EXP Sub Single', 'Facebook', 'Family', 'Gilt', 'Gilt City $70', 'Gilt City VIP $95', 'Girl Scout 10'
		, 'Girl Scout Group', 'Goldstar', 'Goldstar ADA', 'Goldstar Cyber', 'Goldstar II', 'Goldstar II ADA', 'Goldstar Mezz'
		, 'Goldstar Orch', 'Google', 'Google Group', 'GOPRO', 'Got Your 6', 'Group', 'Group 2', 'Group Access Les Miz', 'Group ADA'
		, 'Group Corp', 'Group Corp Les Miz', 'Group CPMC', 'Group Dreamworks', 'Group Early', 'Group II', 'Group JHC', 'Group K'
		, 'Group K ADA', 'Group Les Miz', 'Group Student', 'Group2 Access', 'Group2 Corp', 'Group3', 'Groupon', 'Half Price Offer'
		, 'Ham Group', 'Ham Group ADA', 'HMI PRIME', 'HRC Group Corp', 'HRC Group Night', 'Human Rights', 'Idiot Club', 'KBLX Offer'
		, '*LGBTQ', 'Lottery', 'Meet/Greet Mem', 'Member', 'Member ADA', 'Member Corp', 'Member Single', 'Member Single ADA'
		, 'Member Special', 'Member Special Accessible', 'Member Special ADA', 'Member Special MG', 'Member Special New'
		, 'Member Special Super50', 'Mormon Member Special Accessible', 'Mormon Member Special', 'Non Lottery', 'Non Lottery 40'
		, 'Non Lottery 50', 'Online Lottery', 'Online Rush', 'Potter Member Special', 'Rush', 'Rush Student', 'Section 1 * Orchestra - 4 Show'
		, 'Section 2 * Mezzanine - 4 Show', 'Section 3 * Balcony - 4 Show', 'SF Aids Foundation', 'SFZOO', 'SHN Events', 'Sisters'
		, 'Skyline', 'Special Offer', 'STS', 'STS ADA', 'Sub Access', 'Sub Single', 'Sub Single Access', 'Sub Single Accessible'
		, 'Sub Single BOM', 'Sub Single Premium', 'Subs 1027A', 'Subs Acc 1027A', 'Subs Premium', 'Subscription', 'TodayTix'
		, 'Trevor', 'TT Rush', 'Twitter', 'Two Pack: GCorp+Youth (under 15)', 'Two Pack: Group+Youth (under 15)'
		, 'Two Pack: Member+Youth (under 15)', 'UCSF', 'University Group', 'VIP Meet/Greet Mem', 'Young Pro', 'ZZ Group Corp (A)'
		, 'ZZ Group NAMI', 'ZZ Group Normal', 'ZZ VH1C') AND PriceTypeName LIKE '%ADA' AND DimPromoID = -1


-- Single Show - Non Member Presale Single --
UPDATE f
SET DimTicketClassID = 79
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 7 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Singles'
	AND pricetype.PriceTypeName NOT IN ('1110 Group', '1110 Group ADA', '1110 Group Corp', '1110 Member', '1110 Member ADA'
		, '1110 Member Single', '21Thirtyfive', '47 Member Special', '47 Member Special ADA', 'AARP', 'Academy of Friends'
		, 'Amazon', 'Arts Offer', 'Battery', 'Booth', 'BOM Corp', 'BOM Sub Single Accessible', 'Boy Scout Group', 'Boy Scout Group ADA'
		, 'CAL Berkeley', 'Champion Group', 'Champion Group ADA', 'Champion Group Student', 'Cheer', 'D20', 'Discount'
		, 'EXP Group', 'EXP Sub Single', 'Facebook', 'Family', 'Gilt', 'Gilt City $70', 'Gilt City VIP $95', 'Girl Scout 10'
		, 'Girl Scout Group', 'Goldstar', 'Goldstar ADA', 'Goldstar Cyber', 'Goldstar II', 'Goldstar II ADA', 'Goldstar Mezz'
		, 'Goldstar Orch', 'Google', 'Google Group', 'GOPRO', 'Got Your 6', 'Group', 'Group 2', 'Group Access Les Miz', 'Group ADA'
		, 'Group Corp', 'Group Corp Les Miz', 'Group CPMC', 'Group Dreamworks', 'Group Early', 'Group II', 'Group JHC', 'Group K'
		, 'Group K ADA', 'Group Les Miz', 'Group Student', 'Group2 Access', 'Group2 Corp', 'Group3', 'Groupon', 'Half Price Offer'
		, 'Ham Group', 'Ham Group ADA', 'HMI PRIME', 'HRC Group Corp', 'HRC Group Night', 'Human Rights', 'Idiot Club', 'KBLX Offer'
		, '*LGBTQ', 'Lottery', 'Meet/Greet Mem', 'Member', 'Member ADA', 'Member Corp', 'Member Single', 'Member Single ADA'
		, 'Member Special', 'Member Special Accessible', 'Member Special ADA', 'Member Special MG', 'Member Special New'
		, 'Member Special Super50', 'Mormon Member Special Accessible', 'Mormon Member Special', 'Non Lottery', 'Non Lottery 40'
		, 'Non Lottery 50', 'Online Lottery', 'Online Rush', 'Potter Member Special', 'Rush', 'Rush Student', 'Section 1 * Orchestra - 4 Show'
		, 'Section 2 * Mezzanine - 4 Show', 'Section 3 * Balcony - 4 Show', 'SF Aids Foundation', 'SFZOO', 'SHN Events', 'Sisters'
		, 'Skyline', 'Special Offer', 'STS', 'STS ADA', 'Sub Access', 'Sub Single', 'Sub Single Access', 'Sub Single Accessible'
		, 'Sub Single BOM', 'Sub Single Premium', 'Subs 1027A', 'Subs Acc 1027A', 'Subs Premium', 'Subscription', 'TodayTix'
		, 'Trevor', 'TT Rush', 'Twitter', 'Two Pack: GCorp+Youth (under 15)', 'Two Pack: Group+Youth (under 15)'
		, 'Two Pack: Member+Youth (under 15)', 'UCSF', 'University Group', 'VIP Meet/Greet Mem', 'Young Pro', 'ZZ Group Corp (A)'
		, 'ZZ Group NAMI', 'ZZ Group Normal', 'ZZ VH1C') AND PriceTypeName NOT LIKE '%ADA' AND DimPromoID <> -1



-- Single Show - Non Member Presale Single ADA --
UPDATE f
SET DimTicketClassID = 80
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceType_V2 pricetype ON f.DimPriceTypeId = pricetype.DimPriceTypeId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 7 AND DimPlanTypeID = 3 AND pricetype.AV_price_type_group = 'Singles'
	AND pricetype.PriceTypeName NOT IN ('1110 Group', '1110 Group ADA', '1110 Group Corp', '1110 Member', '1110 Member ADA'
		, '1110 Member Single', '21Thirtyfive', '47 Member Special', '47 Member Special ADA', 'AARP', 'Academy of Friends'
		, 'Amazon', 'Arts Offer', 'Battery', 'Booth', 'BOM Corp', 'BOM Sub Single Accessible', 'Boy Scout Group', 'Boy Scout Group ADA'
		, 'CAL Berkeley', 'Champion Group', 'Champion Group ADA', 'Champion Group Student', 'Cheer', 'D20', 'Discount'
		, 'EXP Group', 'EXP Sub Single', 'Facebook', 'Family', 'Gilt', 'Gilt City $70', 'Gilt City VIP $95', 'Girl Scout 10'
		, 'Girl Scout Group', 'Goldstar', 'Goldstar ADA', 'Goldstar Cyber', 'Goldstar II', 'Goldstar II ADA', 'Goldstar Mezz'
		, 'Goldstar Orch', 'Google', 'Google Group', 'GOPRO', 'Got Your 6', 'Group', 'Group 2', 'Group Access Les Miz', 'Group ADA'
		, 'Group Corp', 'Group Corp Les Miz', 'Group CPMC', 'Group Dreamworks', 'Group Early', 'Group II', 'Group JHC', 'Group K'
		, 'Group K ADA', 'Group Les Miz', 'Group Student', 'Group2 Access', 'Group2 Corp', 'Group3', 'Groupon', 'Half Price Offer'
		, 'Ham Group', 'Ham Group ADA', 'HMI PRIME', 'HRC Group Corp', 'HRC Group Night', 'Human Rights', 'Idiot Club', 'KBLX Offer'
		, '*LGBTQ', 'Lottery', 'Meet/Greet Mem', 'Member', 'Member ADA', 'Member Corp', 'Member Single', 'Member Single ADA'
		, 'Member Special', 'Member Special Accessible', 'Member Special ADA', 'Member Special MG', 'Member Special New'
		, 'Member Special Super50', 'Mormon Member Special Accessible', 'Mormon Member Special', 'Non Lottery', 'Non Lottery 40'
		, 'Non Lottery 50', 'Online Lottery', 'Online Rush', 'Potter Member Special', 'Rush', 'Rush Student', 'Section 1 * Orchestra - 4 Show'
		, 'Section 2 * Mezzanine - 4 Show', 'Section 3 * Balcony - 4 Show', 'SF Aids Foundation', 'SFZOO', 'SHN Events', 'Sisters'
		, 'Skyline', 'Special Offer', 'STS', 'STS ADA', 'Sub Access', 'Sub Single', 'Sub Single Access', 'Sub Single Accessible'
		, 'Sub Single BOM', 'Sub Single Premium', 'Subs 1027A', 'Subs Acc 1027A', 'Subs Premium', 'Subscription', 'TodayTix'
		, 'Trevor', 'TT Rush', 'Twitter', 'Two Pack: GCorp+Youth (under 15)', 'Two Pack: Group+Youth (under 15)'
		, 'Two Pack: Member+Youth (under 15)', 'UCSF', 'University Group', 'VIP Meet/Greet Mem', 'Young Pro', 'ZZ Group Corp (A)'
		, 'ZZ Group NAMI', 'ZZ Group Normal', 'ZZ VH1C') AND PriceTypeName LIKE '%ADA' AND DimPromoID <> -1



-- Unseated New Acquisition Bundle Tuesday Evening --
UPDATE f
SET DimTicketClassID = 81
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Tuesday Evening'



-- Unseated New Acquisition Bundle Wednesday Matinee --
UPDATE f
SET DimTicketClassID = 82
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Wednesday Matinee'



-- Unseated New Acquisition Bundle Wednesday Evening --
UPDATE f
SET DimTicketClassID = 83
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Wednesday Evening'



-- Unseated New Acquisition Bundle Thursday Evening --
UPDATE f
SET DimTicketClassID = 84
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Thursday Evening'



-- Unseated New Acquisition Bundle Friday Evening --
UPDATE f
SET DimTicketClassID = 85
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Friday Evening'



-- Unseated New Acquisition Bundle Saturday Matinee --
UPDATE f
SET DimTicketClassID = 86
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Saturday Matinee'



-- Unseated New Acquisition Bundle Saturday Evening --
UPDATE f
SET DimTicketClassID = 87
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Saturday Evening'



-- Unseated New Acquisition Bundle Sunday Matinee --
UPDATE f
SET DimTicketClassID = 88
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 11 AND bundle.PlanName = 'Sunday Matinee'



-- Choice --
UPDATE f
SET DimTicketClassID = 89
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPlan_V2 bundle ON f.DimPlanId = bundle.DimPlanId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE DimTicketTypeID = 12 AND DimPlanTypeId = 5




/*****************************************************************************************************************
															SEAT TYPE
******************************************************************************************************************/
--SELECT DimSeatTypeId, SeatTypeName FROM dbo.DimSeatType_V2 ORDER BY SeatTypeName
-- ADA Fixed Seat --
UPDATE f
SET DimSeatTypeID = 1
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'ADA Fixed Seat'



-- ADA PL1 Fixed Seat --
UPDATE f
SET DimSeatTypeID = 42
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'ADA PL1 Fixed Seat'



-- ADA PL1 WC Space --
UPDATE f
SET DimSeatTypeID = 43
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'ADA PL1 WC Space'



-- ADA PL2 Fixed Seat --
UPDATE f
SET DimSeatTypeID = 44
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'ADA PL2 Fixed Seat'



-- ADA PL2 WC Space --
UPDATE f
SET DimSeatTypeID = 45
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'ADA PL2 WC Space'



-- ADA Whlchair Space --
UPDATE f
SET DimSeatTypeID = 2
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName IN ('ADA Whlchair Space', 'Whlchair Space')



-- Balcony --
UPDATE f
SET DimSeatTypeID = 3
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Balcony'



-- Balcony A - C --
UPDATE f
SET DimSeatTypeID = 4
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Balcony A - C'



-- Balcony D - J --
UPDATE f
SET DimSeatTypeID = 5
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Balcony D - J'



-- Balcony L and M --
UPDATE f
SET DimSeatTypeID = 46
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Balcony L and M'



-- Balcony Side --
UPDATE f
SET DimSeatTypeID = 6
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Balcony Side'



-- Box --
UPDATE f
SET DimSeatTypeID = 7
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName IN ('Box')



-- Boxes --
UPDATE f
SET DimSeatTypeID = 47
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName IN ('Boxes')



-- First Tier --
UPDATE f
SET DimSeatTypeID = 8
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'First Tier'



-- Front Balcony --
UPDATE f
SET DimSeatTypeID = 48
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Front Balcony'



-- General Admission --
UPDATE f
SET DimSeatTypeID = 9
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'General Admission'



-- Girl Scout Balc Offer --
UPDATE f
SET DimSeatTypeID = 49
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Girl Scout Balc Offer'



-- Girl Scout Mezz Offer --
UPDATE f
SET DimSeatTypeID = 10
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Girl Scout Mezz Offer'



-- INBA Balc Offer --
UPDATE f
SET DimSeatTypeID = 50
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'INBA Balc Offer'



-- INBA Balc Rear Offer --
UPDATE f
SET DimSeatTypeID = 51
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'INBA Balc Rear Offer'



-- Limited View --
UPDATE f
SET DimSeatTypeID = 11
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Limited View'



-- Limited View Loge --
UPDATE f
SET DimSeatTypeID = 12
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Limited View Loge'



-- Limited View Orch --
UPDATE f
SET DimSeatTypeID = 13
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Limited View Orch'



-- Loge --
UPDATE f
SET DimSeatTypeID = 14
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Loge'



-- Loge Side View --
UPDATE f
SET DimSeatTypeID = 15
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Loge Side View'



-- Mezzanine --
UPDATE f
SET DimSeatTypeID = 16
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Mezzanine'



-- Mezzanine Rear --
UPDATE f
SET DimSeatTypeID = 17
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Mezzanine Rear'



-- Mezzanine Side --
UPDATE f
SET DimSeatTypeID = 18
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Mezzanine Side'



-- Mezzanine Side and Rear --
UPDATE f
SET DimSeatTypeID = 52
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Mezzanine Side and Rear'



-- Obstructed View --
UPDATE f
SET DimSeatTypeID = 19
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Obstructed View'



-- Orch A - O Side View --
UPDATE f
SET DimSeatTypeID = 20
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orch A - O Side View'



-- Orch PL1 --
UPDATE f
SET DimSeatTypeID = 21
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orch PL1'



-- Orch PL2 --
UPDATE f
SET DimSeatTypeID = 22
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orch PL2'



-- Orch PL3 --
UPDATE f
SET DimSeatTypeID = 23
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orch PL3'



-- Orchestra --
UPDATE f
SET DimSeatTypeID = 24
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra'



-- Orchestra A - C --
UPDATE f
SET DimSeatTypeID = 53
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra A - C'



-- Orchestra A - O --
UPDATE f
SET DimSeatTypeID = 25
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra A - O'



-- Orchestra D - O --
UPDATE f
SET DimSeatTypeID = 54
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra D - O'



-- Orchestra P - BB --
UPDATE f
SET DimSeatTypeID = 26
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra P - BB'



-- Orchestra P - V --
UPDATE f
SET DimSeatTypeID = 55
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra P - V'



-- Orchestra Rear --
UPDATE f
SET DimSeatTypeID = 27
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra Rear'



-- Orchestra Side --
UPDATE f
SET DimSeatTypeID = 28
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra Side'



-- Orchestra Side and Rear --
UPDATE f
SET DimSeatTypeID = 29
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Orchestra Side and Rear'



-- Partial View Balc --
UPDATE f
SET DimSeatTypeID = 30
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Partial View Balc'



-- Partial View Loge --
UPDATE f
SET DimSeatTypeID = 31
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Partial View Loge'



-- Partial View Orch --
UPDATE f
SET DimSeatTypeID = 32
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Partial View Orch'



-- Pit --
UPDATE f
SET DimSeatTypeID = 56
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Pit'



-- Premium Orch --
UPDATE f
SET DimSeatTypeID = 58
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Premium Orchestra'



-- Prime Loge --
UPDATE f
SET DimSeatTypeID = 33
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Prime Loge'



-- Prime Orch --
UPDATE f
SET DimSeatTypeID = 34
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName IN ('Prime Orch', 'Prime Orchestra')



-- Rear ADA Fixed Seat --
UPDATE f
SET DimSeatTypeID = 59
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName IN ('Rear ADA Fixed Seat')



-- Rear ADA Whlchair Space --
UPDATE f
SET DimSeatTypeID = 60
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName IN ('Rear ADA Whlchair Space')



-- Second Tier --
UPDATE f
SET DimSeatTypeID = 35
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Second Tier'



-- Special Offer Balc --
UPDATE f
SET DimSeatTypeID = 36
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer Balc'



-- Special Offer Balc Side --
UPDATE f
SET DimSeatTypeID = 37
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer Balc Side'



-- Special Offer Loge --
UPDATE f
SET DimSeatTypeID = 61
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer Loge'



-- Special Offer Mezz --
UPDATE f
SET DimSeatTypeID = 38
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer Mezz'



-- Special Offer Orch --
UPDATE f
SET DimSeatTypeID = 39
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer Orch'



-- Special Offer Prime Orch --
UPDATE f
SET DimSeatTypeID = 62
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer Prime Orch'



-- Special Offer VIP Orch --
UPDATE f
SET DimSeatTypeID = 40
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'Special Offer VIP Orch'




-- University Mezz Offer --
UPDATE f
SET DimSeatTypeID = 63
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'University Mezz Offer'



-- VIP Orchestra --
UPDATE f
SET DimSeatTypeID = 41
FROM stg.AV_FactTicketSales f
JOIN dbo.DimPriceLevel_V2 valuelegend ON f.DimPriceLevelId = valuelegend.DimPriceLevelId
JOIN dbo.DimSeason_V2 season ON f.DimSeasonId = season.DimSeasonId
WHERE PriceLevelName = 'VIP Orchestra'


END
























GO
