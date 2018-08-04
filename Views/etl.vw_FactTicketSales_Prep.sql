SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_FactTicketSales_Prep]
AS
SELECT c.customer_id
	, c.customer_number
	, NULL AS legacy_customer_number
	, o.order_contact_id contact_id
	, se.series_id
	, p.performance_id
	, o.order_id
	, a.orderadmission_id
	, pt.price_type_id
	, v.venue_id
	, st.seat_id
	, o.order_number
	, CASE WHEN pt.price_type_group = 'Group' THEN CAST(ISNULL(CAST(a.orderadmission_net_paid AS DECIMAL(18,2))/100,0) AS DECIMAL(18,2))
			WHEN pt.price_type_group IS NULL THEN CAST(ISNULL(CAST(a.orderadmission_amount AS DECIMAL(18,2))/100,0) AS DECIMAL(18,2))
			ELSE CAST(ISNULL(CAST(a.orderadmission_amount AS DECIMAL(18,2))/100,0) AS DECIMAL(18,2)) END AS Amount
--SELECT *
FROM ods.AV_ts_order_admission a (NOLOCK)
JOIN ods.AV_ts_price_type pt (NOLOCK)
	ON a.orderadmission_price_type_id = pt.price_type_id
JOIN ods.AV_ts_seat st (NOLOCK)
	ON a.orderadmission_seat_id = st.seat_id
JOIN ods.AV_ts_section sc (NOLOCK)
	ON st.seat_section_id = sc.section_id
JOIN ods.AV_ts_performance p (NOLOCK)
	ON a.orderadmission_performance_id = p.performance_id
JOIN ods.AV_ts_order o (NOLOCK)
	ON a.orderadmission_order_id = o.order_id
JOIN ods.AV_ts_admission ad (NOLOCK)
	ON a.orderadmission_admission_id = ad.admission_id
JOIN ods.AV_ts_series se (NOLOCK)
	ON p.performance_series_id = se.series_id
JOIN ods.AV_ts_venue v (NOLOCK)
	ON se.series_venue_id = v.venue_id
JOIN ods.AV_ts_audit au (NOLOCK)
	ON o.order_create_audit_id = au.audit_id
--JOIN ods.AV_ts_user_role u (NOLOCK)
--	ON au.user_role_id = u.userrole_id
LEFT JOIN ods.AV_ts_customer c (NOLOCK)
	ON o.order_customer_id = c.customer_id
LEFT JOIN ods.AV_ts_seat_template_seat sts (NOLOCK)
	ON sts.seattempseat_template_id = ad.admission_price_template_id
	AND ad.admission_seat_id = sts.seattempseat_seat_id
LEFT JOIN ods.AV_ts_promotion pr (NOLOCK)
	ON a.orderadmission_promo_code_id = pr.promocode_id
LEFT JOIN (
			SELECT tkt.ticket_item_id, tkt.ticket_status, tkt.ticket_number
			FROM ods.AV_ts_ticket tkt (NOLOCK)
			WHERE tkt.ticket_record_state = 0
		) tkt ON ad.admission_id = tkt.ticket_item_id














GO
