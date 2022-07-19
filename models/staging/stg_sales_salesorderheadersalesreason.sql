with source_data as (
    select
        salesorderid
        , max(salesreasonid) as salesreasonid
    from {{source('adventureworks_data','sales_salesorderheadersalesreason')}}
    group by salesorderid
)
    , concat_source as (
        select
           source_data.salesorderid
            , source_data.salesreasonid
            , concat(salesorderid, '',salesreasonid) as orderreason_id
        from source_data
    )

select *
from concat_source