with source as (
    select * from {{ source('raw', 'bing') }}
),

renamed as (
    select
        date_date,
        paid_source,
        camPGN_name as campaign_name,
        cast(ads_cost as float64) as ads_cost,
        impression,
        click
    from source
)

select * from renamed