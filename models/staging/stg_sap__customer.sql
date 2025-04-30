with
    customer as (
        select 
            {{ int_col('customerid') }} as customer_id
            , {{ int_col('personid') }} as person_id
            , {{ int_col('territoryid') }} as territory_id
            , {{ int_col('storeid') }} as store_id
        from {{ source('raw_adventure_works', 'customer') }}
    )

select *
from customer