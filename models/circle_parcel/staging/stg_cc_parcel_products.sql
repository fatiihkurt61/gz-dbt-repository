WITH raw_data AS (
    SELECT * FROM {{ source('raw_data_circle', 'raw_cc_parcel_product') }}
)
SELECT
    CAST(ParcEl_id AS STRING) AS parcel_id,
    CAST(Model_mAME AS STRING) AS model_m,
    CAST(QUANTITY AS INT64) AS quantity
FROM raw_data