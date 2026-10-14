select
    {{ dbt_utils.generate_surrogate_key(['t.truck_id']) }} as truck_key,
    t.truck_id,
    t.primary_city,
    t.region,
    t.country,
    t.franchise_flag,
    t.ev_flag,
    t.truck_opening_date
from {{ ref('stg_trucks') }} t
