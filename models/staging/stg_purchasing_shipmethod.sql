with source_data as (
    select
        shipmethodid
        , name as ship_name
        , shipbase
        , shiprate
    from {{source('adventureworks_data','purchasing_shipmethod')}}
)

select *
from source_data