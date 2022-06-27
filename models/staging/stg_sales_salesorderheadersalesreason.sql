with source_data as (
    select
        salesorderid
        , salesreasonid
    from {{source('adventureworks_data','sales_salesorderheadersalesreason')}}
)

select *
from source_data