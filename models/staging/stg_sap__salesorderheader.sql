with
    salesorderheader as (
        select
            {{ int_col('salesorderid') }} as sales_order_id
            , {{ int_col('customerid') }} as customer_id
            , {{ int_col('salespersonid') }} as sales_person_id
            , {{ int_col('creditcardid') }} as credit_card_id
            , {{ int_col('territoryid') }} as territory_id
            , {{ int_col('shiptoaddressid') }} as ship_to_address_id
            , cast(subtotal as numeric) as sub_total
            , cast(taxamt as numeric) as tax_amount
            , cast(freight as numeric) as freight
            , cast(totaldue as numeric) as transaction_amount
            , date(orderdate) as order_date
            , cast(onlineorderflag as boolean) as online_order_flag
            , coalesce(
                case
                    when status = 1 then 'In process'
                    when status = 2 then 'Approved'
                    when status = 3 then 'Backordered'
                    when status = 4 then 'Rejected'
                    when status = 5 then 'Shipped'
                    when status = 6 then 'Cancelled'
                end, 'not provided') as order_status
        from {{ source('raw_adventure_works', 'salesorderheader') }}
    )
select *
from salesorderheader