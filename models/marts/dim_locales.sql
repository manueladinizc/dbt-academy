with
    address_with_geo as (
        select *
        from {{ ref('int_address_locales') }}
    )

    , final as (
        select
            row_number() over (order by ship_to_address_id) as sk_locales,
            ship_to_address_id as locales_id,
            address_id,
            city,
            state_province_name,
            state_province_code,
            country_region_name,
            country_region_code,
            territory_name,
            geographic_group
        from address_with_geo
    )

select *
from final

