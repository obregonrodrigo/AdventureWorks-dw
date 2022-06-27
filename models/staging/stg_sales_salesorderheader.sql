with source_data as (
    select
        salesorderid
        , revisionnumber
        , purchaseordernumber
        , accountnumber
        , customerid
        , salespersonid
        , territoryid
        , billtoaddressid
        , shiptoaddressid
        , shipmethodid
        , creditcardid
        , currencyrateid
        , cast (orderdate as date) as orderdate
        , cast (duedate as date) as duedate
        , cast (shipdate as date) as shipdate
        , status as order_status
        , subtotal
        , taxamt
        , freight
        , totaldue
    from {{source('adventureworks_data','sales_salesorderheader')}}
)

select *
from source_data