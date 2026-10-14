select
    customer_id,
    first_name,
    last_name,
    city,
    country,
    gender,
    favourite_brand,
    sign_up_date,
    birthday_date,
    e_mail as email
from {{ source('tasty_bytes_customer', 'customer_loyalty') }}
