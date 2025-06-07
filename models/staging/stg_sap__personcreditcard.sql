with personcreditcard as (
    select 
        {{ int_col('businessentityid') }} as business_entity_id
        , {{ int_col('creditcardid') }} as credit_card_id
    from {{ source('raw_adventure_works', 'personcreditcard') }}
)
select *
from personcreditcard