with
    distinct_product_id_salesorderdetail as (
        select
            distinct product_id
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , product as (
        select *
        from {{ ref('stg_sap__product') }}
    )

    , productcategory as (
        select *
        from {{ ref('stg_sap__productcategory') }}
    )

    , productsubcategory as (
        select *
        from {{ ref('stg_sap__productsubcategory') }}
    )

    , final_transformation as (
        select
            row_number() over (order by dps.product_id) as sk_product
            , p.product_id
            , p.product_name
            , p.product_number
            , ps.product_subcategory_name
            , pc.product_category_name
        from distinct_product_id_salesorderdetail dps
        left join product p
            on dps.product_id = p.product_id
        left join productsubcategory ps
            on p.product_subcategory_id = ps.product_subcategory_id
        left join productcategory pc
            on ps.product_category_id = pc.product_category_id
    )
select *
from final_transformation