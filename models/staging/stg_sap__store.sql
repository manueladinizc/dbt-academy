with
    store as (
        select
            {{ int_col('businessentityid') }} as business_entity_id
            , {{ int_col('salespersonid') }} as sales_person_id
            , {{ string_col('name') }} as store_name
        from {{ source('raw_adventure_works', 'store') }}
    )
select *
from store