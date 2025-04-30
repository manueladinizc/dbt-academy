with
    person as (
        select
            {{ int_col('businessentityid') }} as business_entity_id
            , {{ string_col('firstname') }} as first_name
            , {{ string_col('lastname') }} as last_name
            , coalesce(
                case
                    when persontype = 'EM' then 'Employee'
                    when persontype = 'IN' then 'Individual'
                    when persontype = 'SP' then 'Store Person'
                    when persontype = 'VC' then 'Vendor Contact'
                    when persontype = 'SC' then 'Sales Contact'
                    when persontype = 'GC' then 'General Contact'
                end, 'not provided') as person_type
        from {{ source('raw_adventure_works', 'person') }}
    )
select *
from person