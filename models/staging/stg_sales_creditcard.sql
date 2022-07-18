with source_data as (

    select
        creditcardid
        , cardtype
        , cardnumber
        , expmonth
        , expyear
    from {{source('adventureworks_data','sales_creditcard')}}
)

select *
from source_data