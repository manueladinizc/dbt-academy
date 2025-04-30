with
    address as (
        select
            {{ int_col('addressid') }} as address_id
            , {{ int_col('stateprovinceid') }} as state_province_id
            , {{ string_col('city') }} as city
        from {{ source('raw_adventure_works', 'address') }}
    )

select *
from address