with

orders_margin as (
    select * from {{ ref('int_orders_margin') }}
),

ship as (
    select * from {{ ref('stg_raw__ship') }}
)

select
    orders_margin.orders_id,
    orders_margin.date_date,
    round(orders_margin.margin + ship.shipping_fee - (ship.logcost + cast(ship.ship_cost as float64)), 2) as operational_margin,
    orders_margin.quantity,
    orders_margin.revenue,
    orders_margin.purchase_cost,
    orders_margin.margin,
    ship.shipping_fee,
    ship.logcost,
    cast(ship.ship_cost as float64) as ship_cost
from orders_margin
left join ship
    on orders_margin.orders_id = ship.orders_id