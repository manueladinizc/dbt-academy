with
    salesreason as (
        select
            {{ int_col('salesreasonid') }} as sales_reason_id
            , coalesce({{ string_col('name') }}, 'not provided') as sales_reason_description
            , coalesce({{ string_col('reasontype') }}, 'not provided') as reason_type
        from {{ source('raw_adventure_works', 'salesreason') }}
    ),

    salesorderheadersalesreason as (
        select
            {{ int_col('salesorderid') }} as sales_order_id
            , {{ int_col('salesreasonid') }} as sales_reason_id
        from {{ source('raw_adventure_works', 'salesorderheadersalesreason') }}
    ),

    join_salesreason_salesorderheadersalesreason as (
        select
            sohsr.sales_order_id
            , sr.sales_reason_id
            , sr.sales_reason_description
            , sr.reason_type
        from salesorderheadersalesreason sohsr
        inner join salesreason sr
            on sohsr.sales_reason_id = sr.sales_reason_id
    )
select *
from join_salesreason_salesorderheadersalesreason