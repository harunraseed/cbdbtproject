select
    location_id,
    location,
    city,
    region,
    country
from {{ source('tasty_bytes', 'location') }}
