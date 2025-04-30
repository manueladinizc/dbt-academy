with
    salesterritory as (
        select
          {{ int_col('territoryid')}} as territory_id
          , {{ string_col('name')}} as territory_name
          , {{ string_col('countryregioncode')}} as country_region_code
          , {{ string_col('"group"')}} as geographic_group
        from {{ source('raw_adventure_works', 'salesterritory') }}
    )
select *
from salesterritory