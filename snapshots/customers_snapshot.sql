{% snapshot customers_snapshot %}

{{ config(
    target_schema='snapshots',
    unique_key='customer_id',
    strategy='check',
    check_cols=['city', 'country', 'favourite_brand']
) }}

select
    customer_id,
    first_name,
    last_name,
    city,
    country,
    favourite_brand,
    sign_up_date
from {{ source('tasty_bytes_customer', 'customer_loyalty') }}

{% endsnapshot %}
