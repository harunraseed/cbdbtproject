select
    order_channel,
    count(*) as order_count,
    sum(order_total) as revenue,
    '{{ var("source_file_name") }}' as source_file_name
from {{ ref('stg_orders') }}
where order_ts >= '{{ var("start_date") }}'
group by order_channel
