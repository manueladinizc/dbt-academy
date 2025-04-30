with 
    creditcard as (
        select 
          {{ int_col('creditcardid') }} as credit_card_id
          , {{ string_col('cardtype') }} as card_type
        from {{ source('raw_adventure_works', 'creditcard') }}
    )

    , personcreditcard as (
        select 
            {{ int_col('creditcardid') }} as credit_card_id
            , {{ string_col('businessentityid') }} as business_entity_id
    from {{ source('raw_adventure_works', 'personcreditcard') }}
    )

    , join_creditcard_personcreditcard as (
        select 
            pcc.business_entity_id
            , cc.credit_card_id
            , cc.card_type
        from creditcard cc
        join personcreditcard pcc
            on cc.credit_card_id = pcc.credit_card_id
    )
select *
from join_creditcard_personcreditcard
