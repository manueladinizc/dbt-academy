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

    , person as (
        select *
        from {{ ref('stg_sap__person') }}
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
            store_id,
            store_name,
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

    , final_transformation as (
        select
              row_number() over (order by cws.customer_id) as sk_customer
              , cws.customer_id
              , p.first_name
              , p.last_name
              , p.person_type
              , cws.territory_id
              , cws.store_id
              , cws.store_name
              , cws.order_channel
          from customer_with_store_info cws
          left join person p
              on cws.person_id = p.business_entity_id
    )
select *
from final_transformation