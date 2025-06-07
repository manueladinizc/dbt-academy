with
    personcreditcard as (
        select * from {{ ref('stg_sap__personcreditcard') }}
    ),
    creditcard as (
        select * from {{ ref('stg_sap__creditcard') }}
    ),
    joined as (
        select
            pcc.business_entity_id,
            cc.credit_card_id,
            cc.card_type
        from personcreditcard pcc
        inner join creditcard cc
            on cc.credit_card_id = pcc.credit_card_id
    )
select *
from joined 