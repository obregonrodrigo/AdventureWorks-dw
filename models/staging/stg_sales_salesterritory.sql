with source_data as (
    select
        territoryid
        , name as territory_name
        , countryregioncode
        , "group" as continent
        , salesytd
        , saleslastyear
        , costytd
        , costlastyear
    from {{source('adventureworks_data','sales_salesterritory')}}
)

select *
from source_data