with source_data as (
    select
        salesreasonid as salesreason_id
        , name as reason_name
        , reasontype
    from {{source('adventureworks_data','sales_salesreason')}}
)

select *
from source_data