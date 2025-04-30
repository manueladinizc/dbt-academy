with
    distinct_ship_to_address_id_salesorderheader as (
        select
            distinct ship_to_address_id
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , address as (
        select *
        from {{ ref('stg_sap__address') }}
    )

    , countryregion as (
        select *
        from {{ ref('stg_sap__countryregion') }}
    )

    , stateprovince as (
        select *
        from {{ ref('stg_sap__stateprovince') }}
    )

    , salesterritory as (
        select *
        from {{ ref('stg_sap__salesterritory') }}
    )

, final_transformation as (
    select
        row_number() over (order by dss.ship_to_address_id) as sk_locales
        , dss.ship_to_address_id as locales_id
        , a.address_id
        , a.city
        , sp.state_province_name
        , sp.state_province_code
        , cr.country_region_name
        , cr.country_region_code
        , st.territory_name
        , st.geographic_group
    from distinct_ship_to_address_id_salesorderheader dss
    left join address a
        on dss.ship_to_address_id = a.address_id
    left join stateprovince sp
        on a.state_province_id = sp.state_province_id
    left join countryregion cr
        on sp.country_region_code = cr.country_region_code
    left join salesterritory st
        on sp.territory_id = st.territory_id
)
select *
from final_transformation