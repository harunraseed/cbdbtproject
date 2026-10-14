select
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'dbt_valid_from']) }} as customer_key,
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name       as full_name,
    city,
    country,
    favourite_brand,
    sign_up_date,
    dbt_valid_from                       as valid_from,
    coalesce(dbt_valid_to, '9999-12-31') as valid_to,
    dbt_valid_to is null                 as is_current
from {{ ref('customers_snapshot') }}
