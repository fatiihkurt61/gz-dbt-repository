with

sales as (
    select * from {{ ref('stg_raw__sales') }}
),

product as (
    select * from {{ ref('stg_raw__product') }}
)

select
    sales.date_date,
    sales.orders_id,
    sales.products_id,
    sales.revenue,
    sales.quantity,
    product.purchase_price,
    round(sales.quantity * product.purchase_price, 2) as purchase_cost,
    round(sales.revenue - (sales.quantity * product.purchase_price), 2) as margin
from sales
left join product
    on sales.products_id = product.products_id