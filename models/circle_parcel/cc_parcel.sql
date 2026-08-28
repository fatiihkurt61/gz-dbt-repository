WITH parcel AS (
    SELECT * FROM {{ ref('stg_cc_parcel') }}
),
parcel_product_agg AS (
    SELECT
        parcel_id,
        COUNT(DISTINCT model_m) AS nb_distinct_products,
        SUM(quantity) AS qty
    FROM {{ ref('stg_cc_parcel_products') }}
    GROUP BY parcel_id
)
SELECT
    p.parcel_id,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    p.date_purchase,
    p.date_shipping,
    p.date_delivery,
    p.date_cancelled,
    COALESCE(pa.nb_distinct_products, 0) AS nb_distinct_products,
    COALESCE(pa.qty, 0) AS qty,
    DATE_DIFF(p.date_shipping, p.date_purchase, DAY) AS days_to_ship,
    DATE_DIFF(p.date_delivery, p.date_shipping, DAY) AS days_to_deliver,
    DATE_DIFF(p.date_delivery, p.date_purchase, DAY) AS days_total_delivery,
    CASE WHEN p.date_cancelled IS NOT NULL THEN 1 ELSE 0 END AS is_cancelled
FROM parcel p
LEFT JOIN parcel_product_agg pa USING (parcel_id)