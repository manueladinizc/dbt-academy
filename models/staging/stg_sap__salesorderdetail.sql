with
    salesorderdetail as (
        select
            {{ int_col('salesorderid') }} as sales_order_id
            , {{ int_col('salesorderdetailid') }} as sales_order_detail_id
            , {{ int_col('productid') }} as product_id
            , {{ int_col('orderqty') }} as order_qty
            , cast(unitprice as numeric) as unit_price
            , cast(unitpricediscount as numeric) as unit_price_discount
            , {{ int_col('specialofferid') }} as special_offer_id
        from {{ source('raw_adventure_works', 'salesorderdetail') }}
    )
select *
from salesorderdetail
