select
    i.order_detail_id,
    i.order_id,
    i.menu_item_id,
    m.menu_item_name,
    m.item_category,
    i.quantity,
    i.price,
    m.cost_of_goods_usd * i.quantity as cost_of_goods,
    i.price - (m.cost_of_goods_usd * i.quantity) as gross_profit,
    {{ margin_pct('i.price', 'm.cost_of_goods_usd * i.quantity') }} as margin_pct
from {{ ref('stg_order_items') }} i
join {{ ref('stg_menu') }} m on i.menu_item_id = m.menu_item_id
