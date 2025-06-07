with
    salesorderheadersalesreason as (
        select * from {{ ref('stg_sap__salesorderheadersalesreason') }}
    ),
    salesreason as (
        select * from {{ ref('stg_sap__salesreason') }}
    ),
    joined as (
        select
            sohsr.sales_order_id,
            sr.sales_reason_id,
            sr.sales_reason_description,
            sr.reason_type
        from salesorderheadersalesreason sohsr
        inner join salesreason sr
            on sohsr.sales_reason_id = sr.sales_reason_id
    )
select *
from joined 