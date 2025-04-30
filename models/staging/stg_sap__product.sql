with
    product as (
        select
           {{ int_col('productid') }} as product_id
            , {{ int_col('productsubcategoryid') }} as product_subcategory_id
            , {{ string_col('name') }} as product_name
            , {{ string_col('productnumber') }} as product_number
        from {{ source('raw_adventure_works', 'product') }}
    )
select *
from product