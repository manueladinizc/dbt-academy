with salesreason as (
    select
        {{ int_col('salesreasonid') }} as sales_reason_id
        , {{ string_col('name') }} as sales_reason_description
        , {{ string_col('reasontype') }} as reason_type
    from {{ source('raw_adventure_works', 'salesreason') }}
)
select *
from salesreason