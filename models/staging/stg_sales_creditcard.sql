with source_data as (
    select
        creditcardid as creditcard_id
        , cardtype
        , cardnumber
        , expmonth
        , expyear
    from {{source('adventureworks_data','sales_creditcard')}}
)

select *
from source_data