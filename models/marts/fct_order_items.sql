{{ config(tags=['daily']) }}

select
    p.order_detail_id,
    p.order_id,
    o.order_date,
    o.truck_key,
    o.customer_key,
    m.menu_item_sk as menu_item_key,
    m.brand_category,
    p.quantity,
    p.price as line_revenue,
    p.cost_of_goods,
    p.gross_profit,
    p.margin_pct
from {{ ref('int_order_item_priced') }} p
inner join {{ ref('fct_orders') }} o
    on p.order_id = o.order_id
inner join {{ ref('dim_menu') }} m
    on p.menu_item_id = m.menu_item_id
