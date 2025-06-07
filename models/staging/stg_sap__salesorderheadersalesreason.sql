with salesorderheadersalesreason as (
    select
        {{ int_col('salesorderid') }} as sales_order_id
        , {{ int_col('salesreasonid') }} as sales_reason_id
    from {{ source('raw_adventure_works', 'salesorderheadersalesreason') }}
)
select *
from salesorderheadersalesreason