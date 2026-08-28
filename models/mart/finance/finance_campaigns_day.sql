{{
    config(
        materialized='view'
    )
}}

select
    f.date_date as date,
    round(f.operational_margin - coalesce(c.ads_cost, 0), 2) as ads_margin,
    f.average_basket,
    f.operational_margin,
    coalesce(c.ads_cost, 0) as ads_cost,
    coalesce(c.ads_impression, 0) as ads_impression,
    coalesce(c.ads_clicks, 0) as ads_clicks,
    f.quantity,
    f.revenue,
    f.purchase_cost,
    f.margin,
    f.shipping_fee,
    f.logcost as log_cost,
    f.ship_cost
from {{ ref('finance_days') }} as f
left join {{ ref('int_campaigns_day') }} as c
    using (date_date)
order by date desc