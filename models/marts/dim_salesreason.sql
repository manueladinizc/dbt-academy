with
    salesorderheader as (
        select
            *
        from {{ ref('stg_sap__salesorderheader') }}
    ),

    salesorderheadersalesreason as (
        select
            *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    ),

    final_transformation as (
        select
            row_number() over (order by soh.sales_order_id) as sk_sales_reason
            , soh.sales_order_id
            , sohsr.sales_reason_id
            , coalesce(sohsr.sales_reason_description, 'Other') as sales_reason_description
            , coalesce(sohsr.reason_type, 'not provided') as reason_type
        from salesorderheader soh
        left join salesorderheadersalesreason sohsr
            on soh.sales_order_id = sohsr.sales_order_id
    )
select *
from final_transformation
