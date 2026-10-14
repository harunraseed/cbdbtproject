select
    order_id,
    truck_id,
    location_id,
    customer_id,
    order_channel,
    order_ts,
    cast(order_ts as date) as order_date,
    order_currency,
    order_amount,
    order_tax_amount,
    order_discount_amount,
    order_total
from {{ source('tasty_bytes', 'order_header') }}
where order_ts >= '2022-01-01'
