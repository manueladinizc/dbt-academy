with
    countryregion as (
        select 
            {{ string_col('countryregioncode') }} as country_region_code
            , {{ string_col('name') }} as country_region_name
        from {{ source('raw_adventure_works', 'countryregion') }}
    )
select *
from countryregion