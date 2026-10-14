{{ config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail',
    tags=['daily']
) }}

with orders as (
    select * from {{ ref('stg_orders') }}
    {% if is_incremental() %}
        where order_ts > (select dateadd(day, -3, max(order_ts)) from {{ this }})
    {% endif %}
),

items as (
    select
        order_id,
        count(*) as item_count,
        sum(quantity) as total_quantity
    from {{ ref('stg_order_items') }}
    group by order_id
),

customers as (
    select * from {{ ref('dim_customer') }}
),

trucks as (
    select * from {{ ref('dim_truck') }}
)

select
    o.order_id,
    o.order_date,
    o.order_ts,
    t.truck_key,
    c.customer_key,
    o.customer_id,
    o.order_channel,
    t.primary_city as truck_city,
    c.city as customer_city_at_order,
    o.order_amount,
    o.order_total,
    i.item_count,
    i.total_quantity
from orders o
left join items i
    on o.order_id = i.order_id
left join trucks t
    on o.truck_id = t.truck_id
left join customers c
    on
        o.customer_id = c.customer_id
        and o.order_ts >= c.valid_from
        and o.order_ts < c.valid_to
