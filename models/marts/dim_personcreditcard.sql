with
    distinct_credit_card_id_personcreditcard as (
        select
            distinct credit_card_id
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , personcreditcard as (
        select *
        from {{ ref('stg_sap__personcreditcard') }}
    )

    , final_transformation as (
        select
            row_number() over (order by dccp.credit_card_id) as sk_person_credit_card
            , pcc.credit_card_id
            , pcc.business_entity_id
            , pcc.card_type
        from distinct_credit_card_id_personcreditcard dccp
        left join personcreditcard pcc
            on dccp.credit_card_id = pcc.credit_card_id
            where pcc.credit_card_id is not null
    )
select *
from final_transformation