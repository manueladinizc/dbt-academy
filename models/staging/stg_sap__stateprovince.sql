with 
    stateprovince as (
        select
            {{ int_col('stateprovinceid') }} as state_province_id
            , {{ int_col('territoryid') }} as territory_id
            , {{ string_col('stateprovincecode') }} as state_province_code
            , {{ string_col('countryregioncode') }} as country_region_code
            , {{ string_col('name') }} as state_province_name
        from {{ source('raw_adventure_works', 'stateprovince') }}
    )
select *
from stateprovince