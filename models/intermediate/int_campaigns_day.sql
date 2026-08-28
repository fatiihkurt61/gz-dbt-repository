select
    date_date,
    round(sum(ads_cost), 2) as ads_cost,
    sum(impression) as ads_impression,
    sum(click) as ads_clicks
from {{ ref('int_campaigns') }}
group by date_date
order by date_date desc