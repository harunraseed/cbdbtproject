-- Every order's header total should match the sum of its line prices
-- within one cent. Return the orders where it does not.

with items as (
    select
        order_id,
        sum(price) as items_total
    from {{ ref('stg_order_items') }}
    group by order_id
)

select
    o.order_id,
    o.order_total,
    i.items_total
from {{ ref('stg_orders') }} o
join items i on o.order_id = i.order_id
where abs(o.order_total - i.items_total) > 0.01
