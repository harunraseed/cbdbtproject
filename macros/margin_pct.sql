{% macro margin_pct(revenue, cost) %}
    round(
        100.0 * ({{ revenue }} - {{ cost }}) / nullif({{ revenue }}, 0),
        4
    )
{% endmacro %}