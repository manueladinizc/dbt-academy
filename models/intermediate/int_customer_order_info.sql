with
    distinct_customer_id_salesorderheader as (
        select
            distinct customer_id,
            online_order_flag
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , customer as (
        select *
        from {{ ref('stg_sap__customer') }}
    )

    , store as (
        select *
        from {{ ref('stg_sap__store') }}
    )

    , customer_with_store_info as (
        select
            dcs.customer_id,
            dcs.online_order_flag,
            c.person_id,
            c.territory_id,
            c.store_id,
            s.store_name,
            case
                when dcs.online_order_flag = True then 'online'
                else 'in-store'
            end as order_channel
        from distinct_customer_id_salesorderheader dcs
        left join customer c
            on dcs.customer_id = c.customer_id
        left join store s
            on c.store_id = s.business_entity_id
    )
select *
from customer_with_store_info