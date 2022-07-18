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
        , case
            when status = 2 then 'Approved'
            when status = 3 then 'Backordered'
            when status = 4 then 'Rejected'
            when status = 5 then 'Shipped'
            when status = 6 then 'Cancelled' 
            else 'In process'
        end as sales_status
        , subtotal
        , taxamt
        , freight
        , totaldue
    from {{source('adventureworks_data','sales_salesorderheader')}}
)

select *
from source_data