with
    employee as (
        select
            {{ int_col('businessentityid') }} as business_entity_id
            , {{ string_col('jobtitle') }} as job_title
            , {{ string_col('gender') }} as gender
        from {{ source('raw_adventure_works', 'employee') }}
    )
select *
from employee