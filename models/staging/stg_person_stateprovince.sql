with source_data as (
    select
        stateprovinceid
        , stateprovincecode
        , countryregioncode
        , territoryid
        , name as province_name
    from {{source('adventureworks_data','person_stateprovince')}}
)

select *
from source_data