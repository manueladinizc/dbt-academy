-- Teste: Soma de total_price para 2011 deve ser 12646112.16

with total as (
    select round(sum(total_price), 2) as total_price_2011
    from {{ ref('fct_ordersales') }}
    where extract(year from order_date) = 2011
)

select *
from total
where total_price_2011 != 12646112.16 