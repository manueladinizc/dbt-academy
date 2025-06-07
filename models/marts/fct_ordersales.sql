with
    salesorderdetail as (
        select
            sales_order_id
            , product_id
            , order_qty
            , unit_price
            , unit_price_discount
            , order_qty * unit_price as total_price
            , order_qty * unit_price * (1 - unit_price_discount) as total_price_with_discounted
        from {{ ref('stg_sap__salesorderdetail') }}
    )


    , salesorderheader as (
        select
            sales_order_id
            , customer_id
            , sales_person_id
            , territory_id
            , ship_to_address_id
            , credit_card_id
            , order_status
            , online_order_flag
            , transaction_amount
            , tax_amount
            , freight
            , transaction_amount + tax_amount + freight as total_amount
            , order_date
        from {{ ref('stg_sap__salesorderheader') }}
    )


    , dim_customer as (
        select
            sk_customer
            , customer_id
        from {{ ref('dim_customer') }}
    )


    , dim_locales as (
        select
            sk_locales
            , locales_id
        from {{ ref('dim_locales') }}
    )


    , dim_personcreditcard as (
        select
            sk_person_credit_card
            , credit_card_id
        from {{ ref('dim_personcreditcard') }}
    )


    , dim_products as (
        select
            sk_product
            , product_id
        from {{ ref('dim_products') }}
    )


    , joined_order_details as (
        select
            sod.sales_order_id
            , sod.product_id
            , sod.order_qty
            , sod.unit_price
            , sod.unit_price_discount
            , sod.total_price
            , sod.total_price_with_discounted
        from salesorderdetail sod
    )


    , joined_order_headers as (
        select
            soh.sales_order_id
            , soh.customer_id
            , soh.sales_person_id
            , soh.territory_id
            , soh.ship_to_address_id
            , soh.credit_card_id
            , soh.order_status
            , soh.online_order_flag
            , soh.transaction_amount
            , soh.tax_amount
            , soh.freight
            , soh.total_amount
            , soh.order_date
        from salesorderheader soh
    )


    , final_transformation as (
        select
            dc.sk_customer as fk_customer
            , dl.sk_locales as fk_locales
            , dpc.sk_person_credit_card as fk_person_credit_card
            , dp.sk_product as fk_product
            , joh.sales_person_id as fk_seller
            , jod.sales_order_id as fk_sales_order
            , jod.total_price_with_discounted
            , jod.order_qty as order_product_qty
            , jod.unit_price
            , jod.unit_price_discount
            , jod.total_price
            , joh.order_status
            , joh.online_order_flag
            , joh.transaction_amount
            , joh.tax_amount
            , joh.freight
            , joh.total_amount
            , joh.order_date
           
            , md5(
                coalesce(cast(jod.sales_order_id as varchar), '') ||
                coalesce(cast(jod.product_id as varchar), '') ||
                coalesce(cast(joh.customer_id as varchar), '') ||
                coalesce(cast(joh.ship_to_address_id as varchar), '') ||
                coalesce(cast(joh.credit_card_id as varchar), '') ||
                coalesce(cast(joh.order_date as varchar), '')
              ) as sk_sales_fact
        from joined_order_details jod
        inner join joined_order_headers joh
            on joh.sales_order_id = jod.sales_order_id
        left join dim_customer dc
            on dc.customer_id = joh.customer_id
        left join dim_locales dl
            on dl.locales_id = joh.ship_to_address_id
        left join dim_personcreditcard dpc
            on dpc.credit_card_id = joh.credit_card_id
        left join dim_products dp
            on dp.product_id = jod.product_id
    )


select *
from final_transformation