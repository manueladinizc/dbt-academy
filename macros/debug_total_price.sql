-- macros/debug/debug_total_price.sql
{% macro debug_total_price_2011() %}
    {% set query %}
        select
            sum(total_price) as total_price_2011
        from {{ ref('fct_ordersales') }}
        where extract(year from order_date) = 2011
    {% endset %}


    {% set results = run_query(query) %}
    {% if execute %}
        {% for row in results %}
            {% do log("Total Price 2011: " ~ row[0], info=True) %}
        {% endfor %}
    {% endif %}
{% endmacro %}