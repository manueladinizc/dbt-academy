with
    sales_order_detail as (
        select
            sales_order_id
            , order_qty
            , unit_price
            , unit_price_discount
            , (unit_price * order_qty) as total_price
            , (unit_price * order_qty * (1 - unit_price_discount)) as total_price_with_discounted
        from {{ ref('stg_sap__salesorderdetail') }}
    ),

    sales_order_header as (
        select
            sales_order_id
            , ship_to_address_id
            , transaction_amount
        from {{ ref('stg_sap__salesorderheader') }}
    ),

    dim_locales as (
        select
            sk_locales
            , locales_id
            , country_region_name
        from {{ ref('dim_locales') }}
    ),

    join_sales_locales as (
        select
            sod.sales_order_id
            , dl.sk_locales
            , dl.country_region_name
            , soh.transaction_amount
            , sod.total_price
            , sod.total_price_with_discounted
            , sod.order_qty
        from sales_order_detail sod
        left join sales_order_header soh
            on sod.sales_order_id = soh.sales_order_id
        left join dim_locales dl
            on soh.ship_to_address_id = dl.locales_id
    ),

    aggregate_sales_locales as (
        select
            sk_locales
            , country_region_name
            , sum(transaction_amount) as total_transaction_amount
            , sum(total_price) as total_price
            , sum(total_price_with_discounted) as total_price_with_discounted
            , sum(order_qty) as total_order_qty
        from join_sales_locales
        group by
            sk_locales
            , country_region_name
    )

select *
from aggregate_sales_locales