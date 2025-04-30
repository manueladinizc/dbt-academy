with
    salesorderdetail as (
        select
            sales_order_id
            , product_id
            , order_qty as order_product_qty
            , unit_price
            , unit_price_discount
            , coalesce(unit_price * order_qty, 0) as total_price
            , coalesce(unit_price * order_qty * (1 - unit_price_discount), 0) as total_price_with_discounted
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , salesorderheader as (
        select
            sales_order_id
            , customer_id
            , sales_person_id
            , credit_card_id
            , territory_id
            , ship_to_address_id
            , order_status
            , tax_amount
            , freight
            , transaction_amount
            , order_date
            , online_order_flag
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , dim_customer as (
        select
            sk_customer
            , customer_id
        from {{ ref('dim_customer') }}
    )

    , dim_dates as (
        select
            sk_date_full
            , date_full
        from {{ ref('dim_dates') }}
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

    , dim_salesreason as (
        select
            sk_sales_reason
            , sales_order_id
        from {{ ref('dim_salesreason') }}
    )

    , final_transformation as (
        select
            d_customer.sk_customer as fk_customer
            , d_locales.sk_locales as fk_locales
            , d_personcreditcard.sk_person_credit_card as fk_person_credit_card
            , d_salesreason.sk_sales_reason as fk_sales_reason
            , d_dates.sk_date_full as fk_date_full
            , d_products.sk_product as fk_product
            , soh.sales_person_id as fk_seller
            , sod.sales_order_id as fk_sales_order

            , sod.sales_order_id
            , sod.order_product_qty
            , sod.unit_price
            , sod.unit_price_discount
            , sod.total_price
            , sod.total_price_with_discounted

            , soh.order_status
            , soh.tax_amount
            , soh.freight
            , soh.transaction_amount
            , soh.order_date
            , soh.online_order_flag
        from salesorderdetail sod
        left join salesorderheader soh
            on sod.sales_order_id = soh.sales_order_id
        left join dim_customer d_customer
            on soh.customer_id = d_customer.customer_id
        left join dim_locales d_locales
            on soh.ship_to_address_id = d_locales.locales_id
        left join dim_personcreditcard d_personcreditcard
            on soh.credit_card_id = d_personcreditcard.credit_card_id
        left join dim_salesreason d_salesreason
            on soh.sales_order_id = d_salesreason.sales_order_id
        left join dim_dates d_dates
            on soh.order_date = d_dates.date_full
        left join dim_products d_products
            on sod.product_id = d_products.product_id
    )

select *
from final_transformation
