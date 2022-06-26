with source_data as (
    select
        countryregioncode as countryid
        , name as country_name
    from {{source('adventureworks_data','person_countryregion')}}
)

select *
from source_data