with source_data as (
    select
        customerid
        , personid
        , storeid
        , territoryid
    from {{source('adventureworks_data','sales_customer')}}
)

select *
from source_data