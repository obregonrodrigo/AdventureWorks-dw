with source_data as (
    select
        addressid
        , addressline1
        , addressline2
        , city
        , stateprovinceid
        , postalcode
    from {{source('adventureworks_data','person_address')}}
)

select *
from source_data