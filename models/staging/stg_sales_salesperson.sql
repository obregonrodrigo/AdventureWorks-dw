with source_data as (
    select
        businessentityid
        , territoryid
        , salesquota
        , bonus
        , commissionpct
        , salesytd
        , saleslastyear
    from {{source('adventureworks_data','sales_salesperson')}}
)

select *
from source_data