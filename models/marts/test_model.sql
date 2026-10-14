{% set channels = ['Mobile', 'POS', 'Online', 'Phone'] %}
{# this is a test model for loop concept to dynamically generate revenue columns for each order channel #}

select
    cast(order_ts as date) as order_date,
    {% for ch in channels %}
        sum(case when order_channel = '{{ ch }}' then order_total else 0 end)
            as revenue_{{ ch | lower }}
        {% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('stg_orders') }}
group by 1
