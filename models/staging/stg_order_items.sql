select
    order_detail_id,
    order_id,
    menu_item_id,
    line_number,
    quantity,
    unit_price,
    price,
    order_item_discount_amount
from {{ source('tasty_bytes', 'order_detail') }}
where order_id in (select order_id from {{ ref('stg_orders') }})
