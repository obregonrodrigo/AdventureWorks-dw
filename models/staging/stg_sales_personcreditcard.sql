with source_data as (
    select
        businessentityid
        , creditcardid
    from {{source('adventureworks_data','sales_personcreditcard')}}
)

select *
from source_data