with source_data as (
    select
        salesorderid
        , salesreasonid
        , concat(salesorderid, '',salesreasonid) as orderreason_id
    from {{source('adventureworks_data','sales_salesorderheadersalesreason')}}
)

select *
from source_data