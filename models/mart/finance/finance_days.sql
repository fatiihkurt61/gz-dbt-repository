with

orders as (
    select * from {{ ref('int_orders_operational') }}
)

select
    date_date,
    count(distinct orders_id) as nb_transactions,
    round(sum(revenue), 2) as revenue,
    round(sum(revenue) / nullif(count(distinct orders_id), 0), 2) as average_basket,
    round(sum(margin), 2) as margin,
    round(sum(operational_margin), 2) as operational_margin,
    round(sum(purchase_cost), 2) as purchase_cost,
    round(sum(shipping_fee), 2) as shipping_fee,
    round(sum(logcost), 2) as logcost,
    round(sum(ship_cost), 2) as ship_cost,
    sum(quantity) as quantity
from orders
group by
    date_date
order by
    date_date desc