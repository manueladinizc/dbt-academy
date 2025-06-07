with
    product_with_hierarchy as (
        select *
        from {{ ref('int_product_hierarchy') }}
    )

    , final as (
        select
            row_number() over (order by product_id) as sk_product,
            product_id,
            product_name,
            product_number,
            product_subcategory_name,
            product_category_name
        from product_with_hierarchy
    )

select *
from final
