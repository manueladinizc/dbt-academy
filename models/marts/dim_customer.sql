with
    customer_order_info as (
        select *
        from {{ ref('int_customer_order_info') }}
    )

    , person as (
        select *
        from {{ ref('stg_sap__person') }}
    )

    , final as (
        select
            row_number() over (order by coi.customer_id) as sk_customer,
            coi.customer_id,
            p.first_name,
            p.last_name,
            p.person_type,
            coi.territory_id,
            coi.store_id,
            coi.store_name,
            coi.order_channel
        from customer_order_info coi
        left join person p
            on coi.person_id = p.business_entity_id
    )
select *
from final
