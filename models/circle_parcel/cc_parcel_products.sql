{{ config(
    materialized='table',
    partition_by={
      "field": "date_purchase",
      "data_type": "date",
      "granularity": "day"
    }
) }}

WITH parcel_products AS (
    SELECT * FROM {{ ref('stg_cc_parcel_products') }}
),
parcel AS (
    SELECT * FROM {{ ref('cc_parcel') }}
)
SELECT
    pp.parcel_id,
    pp.model_m,
    pp.quantity,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    p.date_purchase,
    p.date_shipping,
    p.date_delivery,
    p.date_cancelled,
    p.days_to_ship,
    p.days_to_deliver,
    p.days_total_delivery,
    p.is_cancelled
FROM parcel_products pp
LEFT JOIN parcel p USING (parcel_id)