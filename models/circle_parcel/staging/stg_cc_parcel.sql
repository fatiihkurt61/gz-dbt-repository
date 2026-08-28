WITH raw_data AS (
    SELECT * FROM {{ source('raw_data_circle', 'raw_cc_parcel') }}
)
SELECT
    CAST(Parcel_id AS STRING) AS parcel_id,
    Parcel_tracking AS parcel_tracking,
    Transporter AS transporter,
    Priority AS priority,
    PARSE_DATE('%B %e, %Y', Date_purCHase) AS date_purchase,
    PARSE_DATE('%B %e, %Y', Date_sHipping) AS date_shipping,
    PARSE_DATE('%B %e, %Y', DATE_dElivery) AS date_delivery,
    PARSE_DATE('%B %e, %Y', DateCAncelled) AS date_cancelled
FROM raw_data